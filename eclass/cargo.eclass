# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: cargo.eclass
# @SUPPORTED_EAPIS: 7 8
#
# A minimal eclass to handle rust/cargo packages

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

	ECARGO_HOME="${WORKDIR}/cargo_home"
	ECARGO_VENDOR="${S}/vendor"

	RESTRICT="test network-sandbox"

	inherit flag-o-matic

	cargo_pkg_setup() {
		filter-flags -flto*
	}

	cargo_src_compile() {
		cd "${S}" || die "Could not cd to ${S}"

		local build_mode="--release"
		use debug && build_mode="--debug"

		einfo "Building with cargo build ${build_mode}"
		cargo build \
			${build_mode} \
			|| die "cargo build failed"
	}

	cargo_src_install() {
		cd "${S}" || die "Could not cd to ${S}"

		local build_mode=""
		use debug && build_mode="--debug"

		einfo "Installing with cargo install ${build_mode}"
		cargo install \
			--path . \
			${build_mode} \
			--root="${ED}/usr" \
			|| die "cargo install failed"

		rm -f "${ED}/usr/.crates*"

		dedup_symlink "${ED}"
	}

	EXPORT_FUNCTIONS pkg_setup src_compile src_install
fi
