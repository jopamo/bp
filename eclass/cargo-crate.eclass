# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: cargo-crate.eclass
# @BLURB: Lockstep-managed single-crate source package helper
#

if [[ -z ${_LOCKSTEP_CARGO_CRATE_ECLASS} ]]; then
	_LOCKSTEP_CARGO_CRATE_ECLASS=1

	inherit cargo

	CRATE_VERSION=${CRATE_VERSION:-${PV}}
	CRATES="${CRATE_NAME}@${CRATE_VERSION}"
	SRC_URI="https://crates.io/api/v1/crates/${CRATE_NAME}/${CRATE_VERSION}/download -> ${CRATE_NAME}-${CRATE_VERSION}.crate"
	S="${ECARGO_VENDOR}/${CRATE_NAME}-${CRATE_VERSION}"
	LOCKSTEP_CARGO_CRATE_ROOT="/usr/share/lockstep/cargo-crates/${CRATE_NAME}/${CRATE_VERSION}"

	cargo-crate_src_unpack() {
		[[ -n ${CRATE_NAME-} ]] || die "cargo-crate.eclass requires CRATE_NAME"
		[[ -n ${CRATE_CHECKSUM-} ]] || die "cargo-crate.eclass requires CRATE_CHECKSUM"

		_cargo_vendor_crates
		[[ -d ${S} ]] || die "expected unpacked crate directory: ${S}"
	}

	cargo-crate_src_compile() {
		:
	}

	cargo-crate_src_test() {
		:
	}

	cargo-crate_src_install() {
		local vendor_dir="${ECARGO_VENDOR}/${CRATE_NAME}-${CRATE_VERSION}"
		local target="${ED%/}${LOCKSTEP_CARGO_CRATE_ROOT}"

		[[ -d ${vendor_dir} ]] || die "missing vendored crate directory: ${vendor_dir}"
		mkdir -p "${target}" || die
		cp -pR "${vendor_dir}/." "${target}/" || die "failed installing ${CRATE_NAME}-${CRATE_VERSION}"
	}

	EXPORT_FUNCTIONS src_unpack src_compile src_test src_install
fi
