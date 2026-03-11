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

	inherit flag-o-matic multiprocessing

	_cargo_trim_ws() {
		local value=${1}

		value=${value#"${value%%[![:space:]]*}"}
		value=${value%"${value##*[![:space:]]}"}

		printf '%s\n' "${value}"
	}

	_cargo_build_uri_list() {
		local crate_spec crate version uri_list=

		while IFS= read -r crate_spec; do
			crate_spec=$(_cargo_trim_ws "${crate_spec}")
			[[ -n ${crate_spec} ]] || continue

			crate=${crate_spec%@*}
			version=${crate_spec##*@}
			uri_list+=$'\n\t'"https://crates.io/api/v1/crates/${crate}/${version}/download -> ${crate}-${version}.crate"
		done <<< "${CRATES-}"

		printf '%s\n' "${uri_list}"
	}

	_cargo_setup_config() {
		export CARGO_HOME="${ECARGO_HOME}"
		mkdir -p "${CARGO_HOME}" || die
		rm -f "${CARGO_HOME}/config.toml"
	}

	_cargo_setup_profile_config() {
		# Portage strips binaries in the install image; Cargo profile-level
		# stripping would pre-strip release/debug outputs before QA runs.
		export CARGO_PROFILE_DEV_STRIP=none
		export CARGO_PROFILE_RELEASE_STRIP=none
		export CARGO_PROFILE_TEST_STRIP=none
		export CARGO_PROFILE_BENCH_STRIP=none
	}

	_cargo_common_args() {
		local args=()

		# Use Portage parallelism
		args+=( -j "$(makeopts_jobs)" )

		printf '%s\n' "${args[@]}"
	}

	cargo_pkg_setup() {
		filter-flags -flto*
		export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang
	}

	cargo_gen_config() {
		_cargo_setup_config
		_CARGO_GEN_CONFIG_HAS_RUN=1
	}

	cargo_env() {
		_cargo_setup_config
		_cargo_setup_profile_config
		(( ${#} > 0 )) || return 0
		"${@}"
	}

	cargo_src_unpack() {
		[[ -d ${S} ]] || default
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
