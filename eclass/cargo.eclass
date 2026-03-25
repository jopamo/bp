# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: cargo.eclass
# @BLURB: A minimal eclass to handle rust/cargo packages
#
#


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
	# Location of the vendored crates tree generated from CRATES distfiles.
	ECARGO_VENDOR="${WORKDIR}/cargo_vendor"

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

	_cargo_json_escape() {
		local value=${1//\\/\\\\}

		value=${value//\"/\\\"}
		value=${value//$'\n'/\\n}
		value=${value//$'\t'/\\t}

		printf '%s' "${value}"
	}

	_cargo_write_checksum_file() {
		local crate_dir=$1
		local package_checksum=$2
		local file rel_path file_checksum first=1

		{
			printf '{"package":"%s","files":{' "$(_cargo_json_escape "${package_checksum}")"

			while IFS= read -r -d '' file; do
				rel_path=${file#"${crate_dir}/"}
				file_checksum=$(sha256sum "${file}" | awk '{print $1}') || die

				(( first )) || printf ','
				first=0
				printf '"%s":"%s"' \
					"$(_cargo_json_escape "${rel_path}")" \
					"$(_cargo_json_escape "${file_checksum}")"
			done < <(find "${crate_dir}" -type f ! -name '.cargo-checksum.json' -print0 | LC_ALL=C sort -z)

			printf '}}\n'
		} > "${crate_dir}/.cargo-checksum.json" || die "failed writing ${crate_dir}/.cargo-checksum.json"
	}

	_cargo_vendor_crates() {
		local crate_spec crate version crate_file crate_dir package_checksum

		rm -rf "${ECARGO_VENDOR}"
		[[ -n ${CRATES-} ]] || return 0

		mkdir -p "${ECARGO_VENDOR}" || die

		while IFS= read -r crate_spec; do
			crate_spec=$(_cargo_trim_ws "${crate_spec}")
			[[ -n ${crate_spec} ]] || continue

			crate=${crate_spec%@*}
			version=${crate_spec##*@}
			crate_file="${DISTDIR}/${crate}-${version}.crate"
			crate_dir="${ECARGO_VENDOR}/${crate}-${version}"

			[[ -f ${crate_file} ]] || die "missing crate distfile: ${crate_file}"

			tar -C "${ECARGO_VENDOR}" -xzf "${crate_file}" || die "failed unpacking ${crate_file}"
			[[ -d ${crate_dir} ]] || die "expected unpacked crate directory: ${crate_dir}"

			package_checksum=$(sha256sum "${crate_file}" | awk '{print $1}') || die
			_cargo_write_checksum_file "${crate_dir}" "${package_checksum}"
		done <<< "${CRATES-}"
	}

	_cargo_setup_config() {
		export CARGO_HOME="${ECARGO_HOME}"
		mkdir -p "${CARGO_HOME}" || die
		rm -f "${CARGO_HOME}/config.toml"

		[[ -n ${CRATES-} ]] || return 0
		[[ -d ${ECARGO_VENDOR} ]] || die "vendored crates missing: ${ECARGO_VENDOR}; call cargo_src_unpack first"

		cat > "${CARGO_HOME}/config.toml" <<-EOF || die "failed writing ${CARGO_HOME}/config.toml"
			[source.crates-io]
			replace-with = "bp-vendored-sources"

			[source.bp-vendored-sources]
			directory = "${ECARGO_VENDOR}"
		EOF
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
		cargo_gen_config
		_cargo_setup_profile_config
		(( ${#} > 0 )) || return 0
		"${@}"
	}

	cargo_src_unpack() {
		[[ -d ${S} ]] || default
		_cargo_vendor_crates
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
