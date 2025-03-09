# @ECLASS: cargo.eclass
# @SUPPORTED_EAPIS: 7 8

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_CARGO_ECLASS} ]]; then
	_CARGO_ECLASS=1

	RUST_DEPEND="virtual/rust"
	case ${EAPI} in
		7) RUST_DEPEND=">=virtual/rust-1.37.0" ;;
		8) RUST_DEPEND=">=virtual/rust-1.53" ;;
	esac

	inherit flag-o-matic multiprocessing toolchain-funcs

	[[ ! ${CARGO_OPTIONAL} ]] && BDEPEND="${RUST_DEPEND}"

	IUSE="debug"

	ECARGO_HOME="${WORKDIR}/cargo_home"
	ECARGO_VENDOR="${ECARGO_HOME}/gentoo"

	# CRATES: list of crates to download. GIT_CRATES: associative array for crates from git.
	# If CARGO_OPTIONAL is set, ebuild must define its own BDEPEND on virtual/rust.

	ECARGO_REGISTRY_DIR=
	ECARGO_OFFLINE=
	EVCS_UMASK=

	# Derived from CRATES, includes the URIs to place in SRC_URI.
	CARGO_CRATE_URIS=

	declare -p GIT_CRATES &>/dev/null || declare -A GIT_CRATES

	_cargo_set_crate_uris() {
		local crates=${1}
		local -r re='^([a-zA-Z0-9_\-]+)-([0-9]+\.[0-9]+\.[0-9]+.*)$'
		local crate

		CARGO_CRATE_URIS=
		for crate in ${crates}; do
			local name ver
			if [[ ${crate} == *@* ]]; then
				name=${crate%@*}
				ver=${crate##*@}
			else
				[[ ${crate} =~ ${re} ]] || die "Could not parse name/version from crate: ${crate}"
				name="${BASH_REMATCH[1]}"
				ver="${BASH_REMATCH[2]}"
			fi
			CARGO_CRATE_URIS+="https://crates.io/api/v1/crates/${name}/${ver}/download -> ${name}-${ver}.crate "
			[[ ${PKGBUMPING} == ${PVR} ]] && return
		done

		if declare -p GIT_CRATES &>/dev/null; then
			local c commit uri dir
			for c in "${!GIT_CRATES[@]}"; do
				IFS=';' read -r uri commit dir <<< "${GIT_CRATES[${c}]}"
				local ext repo_name
				case "${uri}" in
					https://github.com/*)
						repo_name="${uri##*/}"
						uri="${uri%/}/archive/%commit%.tar.gz"
						ext=".gh"
					;;
					https://gitlab.com/*)
						repo_name="${uri##*/}"
						uri="${uri%/}/-/archive/%commit%/${repo_name}-%commit%.tar.gz"
						ext=".gl"
					;;
					*) ext=; repo_name="${c}" ;;
				esac
				CARGO_CRATE_URIS+="${uri//%commit%/${commit}} -> ${repo_name}-${commit}${ext}.tar.gz "
			done
		fi
	}
	_cargo_set_crate_uris "${CRATES}"

	cargo_crate_uris() {
		local crates=${*-${CRATES}}
		[[ -z ${crates} ]] && die "Can't generate SRC_URI from empty input"
		_cargo_set_crate_uris "${crates}"
		echo "${CARGO_CRATE_URIS}"
	}

	cargo_gen_config() {
		mkdir -p "${ECARGO_HOME}" || die
		cat > "${ECARGO_HOME}/config" <<-EOF || die
			[source.gentoo]
			directory = "${ECARGO_VENDOR}"
			[source.crates-io]
			replace-with = "gentoo"
			local-registry = "/nonexistent"
			[net]
			offline = true
			[build]
			jobs = $(makeopts_jobs)
			incremental = false
			[term]
			verbose = true
			$([[ "${NOCOLOR}" = true || "${NOCOLOR}" = yes ]] && echo "color = 'never'")
			$(_cargo_gen_git_config)
		EOF
		export CARGO_HOME="${ECARGO_HOME}"
		_CARGO_GEN_CONFIG_HAS_RUN=1
	}

	_cargo_gen_git_config() {
		declare -p GIT_CRATES 2>/dev/null | grep -q "declare -A" || return 0
		local c commit uri dir
		local -A cpatch
		for c in "${!GIT_CRATES[@]}"; do
			IFS=';' read -r uri commit dir <<< "${GIT_CRATES[${c}]}"
			: "${dir:=${c}-%commit%}"
			cpatch["${uri}"]+="${c} = { path = \"${WORKDIR}/${dir//%commit%/${commit}}\" };;"
		done
		for uri in "${!cpatch[@]}"; do
			printf "[patch.'%s']\n%s\n" "${uri}" "${cpatch["${uri}"]//;;/$'\n'}"
		done
	}

	cargo_src_unpack() {
		mkdir -p "${ECARGO_VENDOR}" "${S}" || die
		local a
		for a in ${A}; do
			case "${a}" in
				*.crate)
					[[ ${PKGBUMPING} == ${PVR} ]] && continue
					ebegin "Loading ${a} into Cargo registry"
					tar -xf "${DISTDIR}/${a}" -C "${ECARGO_VENDOR}/" || die
					local sum pkg
					sum=$(sha256sum "${DISTDIR}/${a}" | cut -d' ' -f1)
					pkg=${a%.crate}
					cat <<-EOF > "${ECARGO_VENDOR}/${pkg}/.cargo-checksum.json"
					{
					  "package": "${sum}",
					  "files": {}
					}
					EOF
					if [[ ${P} == ${pkg}* ]]; then
						tar -xf "${DISTDIR}/${a}" -C "${WORKDIR}" || die
					fi
					eend $?
					;;
				*) unpack "${a}" ;;
			esac
		done
		cargo_gen_config
	}

	cargo_live_src_unpack() {
		[[ "${PV}" == *9999* ]] || die "cargo_live_src_unpack only for live ebuilds"
		[[ "${EBUILD_PHASE}" == "unpack" ]] || die "cargo_live_src_unpack only in src_unpack"
		mkdir -p "${S}" "${ECARGO_VENDOR}" "${ECARGO_HOME}" || die
		local dist=${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}
		: "${ECARGO_REGISTRY_DIR:=${dist}/cargo-registry}"
		local off="${ECARGO_OFFLINE:-${EVCS_OFFLINE}}"
		if [[ ! -d ${ECARGO_REGISTRY_DIR} && ! ${off} ]]; then
			addwrite "${ECARGO_REGISTRY_DIR}"
			mkdir -p "${ECARGO_REGISTRY_DIR}" || die
		fi
		if [[ ${off} ]]; then
			local sd
			for sd in cache index src; do
				[[ -d ${ECARGO_REGISTRY_DIR}/registry/${sd} ]] || die "No valid offline cargo registry"
			done
		fi
		if [[ ${EVCS_UMASK} ]]; then
			local saved=$(umask)
			umask "${EVCS_UMASK}" || die
		fi
		pushd "${S}" >/dev/null || die
		[[ -z ${CARGO_TERM_COLOR} && ("${NOCOLOR}" = true || "${NOCOLOR}" = yes) ]] && export CARGO_TERM_COLOR=never
		[[ -z ${CARGO_TERM_VERBOSE} ]] && export CARGO_TERM_VERBOSE=true
		addwrite "${ECARGO_REGISTRY_DIR}"
		export CARGO_HOME="${ECARGO_REGISTRY_DIR}"
		einfo "cargo fetch ${off:+--offline}"
		cargo fetch ${off:+--offline} || die
		einfo "cargo vendor ${off:+--offline} ${ECARGO_VENDOR}"
		cargo vendor ${off:+--offline} "${ECARGO_VENDOR}" || die
		if [[ -d ${ECARGO_REGISTRY_DIR}/git && ! -L "${ECARGO_HOME}/git" ]]; then
			ln -sv "${ECARGO_REGISTRY_DIR}/git" "${ECARGO_HOME}/git" || die
		fi
		popd >/dev/null || die
		[[ ${CARGO_TERM_COLOR} == never ]] && unset CARGO_TERM_COLOR
		[[ ${CARGO_TERM_VERBOSE} == true ]] && unset CARGO_TERM_VERBOSE
		[[ ${saved} ]] && umask "${saved}" || die
		unset CARGO_HOME
		cargo_gen_config
	}

	cargo_src_configure() {
		[[ -z ${myfeatures} ]] && declare -a myfeatures=()
		declare -p myfeatures 2>/dev/null | grep -q 'declare -a' || die "myfeatures must be array"
		myfeatures=( "${myfeatures[@]/#/--features }" )
		readonly ECARGO_ARGS=( "${myfeatures[@]}" "${@}" "${ECARGO_EXTRA_ARGS}" )
		[[ ${ECARGO_ARGS[@]} ]] && einfo "Configured with: ${ECARGO_ARGS[@]}"
	}

	cargo_src_compile() {
		[[ ${_CARGO_GEN_CONFIG_HAS_RUN} ]] || die "cargo_gen_config not called"
		filter-lto
		tc-export AR CC CXX PKG_CONFIG
		set -- cargo build $(usex debug "" --release) "${ECARGO_ARGS[@]}" "$@"
		einfo "${@}"
		"$@" || die "cargo build failed"
	}

	cargo_src_install() {
		[[ ${_CARGO_GEN_CONFIG_HAS_RUN} ]] || die "cargo_gen_config not called"
		set -- cargo install $(has --path "$@" || echo --path ./) --root "${ED}/usr" \
			${GIT_CRATES[@]:+--frozen} $(usex debug --debug "") "${ECARGO_ARGS[@]}" "$@"
		einfo "${@}"
		"$@" || die "cargo install failed"
		rm -f "${ED}/usr/.crates.toml" "${ED}/usr/.crates2.json" || die
		case ${EAPI:-0} in
			7)
				[[ -d "${S}/man" ]] && doman "${S}/man"
			;;
		esac
	}

	cargo_src_test() {
		[[ ${_CARGO_GEN_CONFIG_HAS_RUN} ]] || die "cargo_gen_config not called"
		set -- cargo test $(usex debug "" --release) "${ECARGO_ARGS[@]}" "$@"
		einfo "${@}"
		"$@" || die "cargo test failed"
	}

	if [[ ! ${CARGO_OPTIONAL} ]]; then
		EXPORT_FUNCTIONS src_unpack src_configure src_compile src_install src_test
	fi
fi
