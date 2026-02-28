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

	RESTRICT+=" test"

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
	ECARGO_VENDOR="${S}/vendor"

	RESTRICT="test network-sandbox"

	inherit flag-o-matic multiprocessing

	_cargo_setup_vendor_config() {
		export CARGO_HOME="${ECARGO_HOME}"
		mkdir -p "${CARGO_HOME}" || die

		if [[ -d ${ECARGO_VENDOR} ]]; then
			cat > "${CARGO_HOME}/config.toml" <<-EOF || die
				[source.crates-io]
				replace-with = "vendored-sources"

				[source.vendored-sources]
				directory = "${ECARGO_VENDOR}"
			EOF
		fi
	}

	_cargo_common_args() {
		local args=()

		# Use Portage parallelism
		args+=( -j "$(makeopts_jobs)" )

		# Only force offline when vendor exists (preserves original behavior)
		if [[ -d ${ECARGO_VENDOR} ]]; then
			args+=( --offline )
		fi

		printf '%s\n' "${args[@]}"
	}

	cargo_pkg_setup() {
		filter-flags -flto*
		export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang
	}

	cargo_src_compile() {
		cd "${S}" || die "Could not cd to ${S}"

		_cargo_setup_vendor_config

		local build_mode="--release"
		use debug && build_mode="--debug"

		mapfile -t common_args < <(_cargo_common_args)

		einfo "Building with cargo build ${build_mode} ${common_args[*]}"
		cargo build \
			${build_mode} \
			"${common_args[@]}" \
			|| die "cargo build failed"
	}

	cargo_src_install() {
		cd "${S}" || die "Could not cd to ${S}"

		_cargo_setup_vendor_config

		local build_mode=""
		use debug && build_mode="--debug"

		mapfile -t common_args < <(_cargo_common_args)

		einfo "Installing with cargo install ${build_mode} ${common_args[*]}"
		cargo install \
			--path . \
			${build_mode} \
			"${common_args[@]}" \
			--root="${ED}/usr" \
			|| die "cargo install failed"

		rm -f "${ED}/usr/.crates*"

		dedup_symlink "${ED}"
	}

	EXPORT_FUNCTIONS pkg_setup src_compile src_install
fi
