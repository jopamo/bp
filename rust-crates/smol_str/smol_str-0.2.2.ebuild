# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="smol_str"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="dd538fb6910ac1099850255cf94a94df6551fbdd602454387d0adb2d1ca6dead"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="small-string optimized string type with O(1) clone"
HOMEPAGE="https://github.com/rust-analyzer/smol_str"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
