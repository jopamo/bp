# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hipstr"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="97971ffc85d4c98de12e2608e992a43f5294ebb625fdb045b27c731b64c4c6d6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another string for Rust: zero-cost borrow and slicing, inline representation for small strings, (atomic) reference counting"
HOMEPAGE="https://github.com/polazarus/hipstr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bstr"
	"default"
	"serde"
	"std"
	"unstable"
)
