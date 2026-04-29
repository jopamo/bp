# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="mockall_derive"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="ca41ce716dda6a9be188b385aa78ee5260fc25cd3802cb2a8afdc6afbe6b6dbf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for Mockall"
HOMEPAGE="https://github.com/asomers/mockall"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly_derive"
)
