# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: cargo.eclass
# @BLURB: A minimal eclass to handle rust/cargo packages
#
#

case "${EAPI:-0}" in
	7|8) ;;
	*) die "cargo.eclass: EAPI=${EAPI} is not supported" ;;
esac

if [[ -z ${_CARGO_VENDOR_ECLASS} ]]; then
	_CARGO_VENDOR_ECLASS=1

	RESTRICT+=" test network-sandbox"

	DEPEND+=" >=virtual/rust-1.60.0"
	RDEPEND="${DEPEND}"
	BDEPEND="${DEPEND}"

	IUSE="debug"

	# @ECLASS_VARIABLE: ECARGO_HOME
	# @DESCRIPTION:
	# Location of the cargo home directory.
	ECARGO_HOME="${WORKDIR}/cargo_home"

	# @ECLASS_VARIABLE: ECARGO_VENDOR
	# @DESCRIPTION:
	# Location of the vendored dependencies.
	ECARGO_VENDOR="${WORKDIR}/cargo_vendor"

	inherit flag-o-matic multiprocessing

	_cargo_trim_ws() {
		local value=${1}

		value=${value#"${value%%[![:space:]]*}"}
		value=${value%"${value##*[![:space:]]}"}

		printf '%s\n' "${value}"
	}

	_cargo_json_escape() {
		local value=${1}

		value=${value//\\/\\\\}
		value=${value//\"/\\\"}
		value=${value//$'\n'/\\n}
		value=${value//$'\r'/\\r}
		value=${value//$'\t'/\\t}

		printf '%s\n' "${value}"
	}

	_cargo_each_crate() {
		local crate_spec

		while IFS= read -r crate_spec; do
			crate_spec=$(_cargo_trim_ws "${crate_spec}")
			[[ -n ${crate_spec} ]] || continue
			printf '%s\n' "${crate_spec}"
		done <<< "${CRATES-}"
	}

	_cargo_crate_name() {
		printf '%s\n' "${1%@*}"
	}

	_cargo_crate_version() {
		printf '%s\n' "${1##*@}"
	}

	_cargo_crate_distfile() {
		printf '%s-%s.crate\n' \
			"$(_cargo_crate_name "${1}")" \
			"$(_cargo_crate_version "${1}")"
	}

	_cargo_build_uri_list() {
		local crate_spec crate version uri_list=

		while IFS= read -r crate_spec; do
			crate=$(_cargo_crate_name "${crate_spec}")
			version=$(_cargo_crate_version "${crate_spec}")
			uri_list+=$'\n\t'"https://crates.io/api/v1/crates/${crate}/${version}/download -> ${crate}-${version}.crate"
		done < <(_cargo_each_crate)

		printf '%s\n' "${uri_list}"
	}

	_cargo_effective_vendor_dir() {
		local candidate

		for candidate in "${ECARGO_VENDOR}" "${PWD}/vendor" "${S}/vendor"; do
			[[ -n ${candidate} && -d ${candidate} ]] || continue
			printf '%s\n' "${candidate}"
			return 0
		done

		return 1
	}

	_cargo_write_checksum_file() {
		local crate_dir=$1
		local crate_file=$2
		local first=1 rel hash package_hash

		package_hash=$(sha256sum "${crate_file}" | awk '{print $1}') || die

		{
			printf '{"files":{'
			while IFS= read -r -d '' rel; do
				rel=${rel#./}
				hash=$(cd "${crate_dir}" && sha256sum "${rel}" | awk '{print $1}') || die
				(( first )) || printf ','
				first=0
				printf '"%s":"%s"' "$(_cargo_json_escape "${rel}")" "${hash}"
			done < <(cd "${crate_dir}" && find . -type f ! -name .cargo-checksum.json -print0 | LC_ALL=C sort -z)
			printf '},"package":"%s"}\n' "${package_hash}"
		} > "${crate_dir}/.cargo-checksum.json" || die
	}

	_cargo_unpack_crate_distfiles() {
		local crate_spec crate_distfile crate_dir missing=0
		local -A seen=()

		[[ -n ${CRATES-} ]] || return 0

		rm -rf -- "${ECARGO_VENDOR}"

		while IFS= read -r crate_spec; do
			[[ -n ${seen["${crate_spec}"]-} ]] && continue
			seen["${crate_spec}"]=1

			crate_distfile=$(_cargo_crate_distfile "${crate_spec}")
			if [[ ! -f ${DISTDIR}/${crate_distfile} ]]; then
				missing=1
				continue
			fi

			mkdir -p "${ECARGO_VENDOR}" || die
			tar -C "${ECARGO_VENDOR}" -xzf "${DISTDIR}/${crate_distfile}" || die

			crate_dir="${ECARGO_VENDOR}/$(_cargo_crate_name "${crate_spec}")-$(_cargo_crate_version "${crate_spec}")"
			[[ -d ${crate_dir} ]] || die "cargo.eclass: ${crate_distfile} did not unpack ${crate_dir}"
			_cargo_write_checksum_file "${crate_dir}" "${DISTDIR}/${crate_distfile}"
		done < <(_cargo_each_crate)

		if (( missing )); then
			rm -rf -- "${ECARGO_VENDOR}"
		fi
	}

	_cargo_unpack_vendor_archives() {
		local distfile

		for distfile in ${A}; do
			[[ ${distfile} == *-crates.tar.* ]] || continue
			[[ -f ${DISTDIR}/${distfile} ]] || continue
			tar -C "${WORKDIR}" -xf "${DISTDIR}/${distfile}" || die
		done
	}

	_cargo_setup_vendor_config() {
		local vendor_dir

		export CARGO_HOME="${ECARGO_HOME}"
		mkdir -p "${CARGO_HOME}" || die

		if vendor_dir=$(_cargo_effective_vendor_dir); then
			export CARGO_NET_OFFLINE=true
			cat > "${CARGO_HOME}/config.toml" <<-EOF || die
				[source.crates-io]
				replace-with = "vendored-sources"

				[source.vendored-sources]
				directory = "${vendor_dir}"

				[net]
				offline = true
			EOF
		else
			rm -f "${CARGO_HOME}/config.toml"
			unset CARGO_NET_OFFLINE
		fi
	}

	_cargo_common_args() {
		local args=()

		# Use Portage parallelism
		args+=( -j "$(makeopts_jobs)" )

		if _cargo_effective_vendor_dir >/dev/null; then
			args+=( --offline )
		fi

		printf '%s\n' "${args[@]}"
	}

	cargo_pkg_setup() {
		filter-flags -flto*
		export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang
	}

	cargo_gen_config() {
		_cargo_setup_vendor_config
		_CARGO_GEN_CONFIG_HAS_RUN=1
	}

	cargo_env() {
		_cargo_setup_vendor_config
		(( ${#} > 0 )) || return 0
		"${@}"
	}

	cargo_src_unpack() {
		[[ -d ${S} ]] || default
		_cargo_unpack_vendor_archives
		_cargo_unpack_crate_distfiles
	}

	cargo_src_configure() {
		cargo_gen_config
	}

	cargo_target_dir() {
		local profile=release
		use debug && profile=debug
		printf '%s/%s\n' "${CARGO_TARGET_DIR:-target}" "${profile}"
	}

	cargo_src_compile() {
		local -a build_mode=( --release )
		use debug && build_mode=()

		mapfile -t common_args < <(_cargo_common_args)

		einfo "Building with cargo build ${build_mode[*]} ${common_args[*]}"
		cargo_env cargo build \
			"${build_mode[@]}" \
			"${common_args[@]}" \
			|| die "cargo build failed"
	}

	cargo_src_test() {
		local -a build_mode=( --release )
		use debug && build_mode=()

		mapfile -t common_args < <(_cargo_common_args)

		einfo "Testing with cargo test ${build_mode[*]} ${common_args[*]}"
		cargo_env cargo test \
			"${build_mode[@]}" \
			"${common_args[@]}" \
			|| die "cargo test failed"
	}

	cargo_src_install() {
		local -a build_mode=()
		use debug && build_mode=( --debug )

		mapfile -t common_args < <(_cargo_common_args)

		einfo "Installing with cargo install ${build_mode[*]} ${common_args[*]}"
		cargo_env cargo install \
			--path . \
			"${build_mode[@]}" \
			"${common_args[@]}" \
			--root="${ED}/usr" \
			|| die "cargo install failed"

		rm -f "${ED}/usr/.crates*"

		dedup_symlink "${ED}"
	}

	CARGO_CRATE_URIS=$(_cargo_build_uri_list)
	_CARGO_GEN_CONFIG_HAS_RUN=1

	EXPORT_FUNCTIONS pkg_setup src_unpack src_configure src_compile src_test src_install
fi
