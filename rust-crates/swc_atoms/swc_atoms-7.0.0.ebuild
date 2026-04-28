# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_atoms"
CRATE_VERSION="7.0.0"
CRATE_CHECKSUM="3500dcf04c84606b38464561edc5e46f5132201cb3e23cf9613ed4033d6b1bb2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Atoms for the swc project."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"__rkyv"
	"rkyv-impl"
	"shrink-to-fit"
)
