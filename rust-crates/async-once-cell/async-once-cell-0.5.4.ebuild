# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="async-once-cell"
CRATE_VERSION="0.5.4"
CRATE_CHECKSUM="4288f83726785267c6f2ef073a3d83dc3f9b81464e9f99898240cced85fce35a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Async single assignment cells and lazy values."
HOMEPAGE="https://github.com/danieldg/async-once-cell"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"critical-section"
	"std"
)
