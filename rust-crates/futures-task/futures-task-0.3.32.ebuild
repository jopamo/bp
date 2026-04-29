# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="futures-task"
CRATE_VERSION="0.3.32"
CRATE_CHECKSUM="037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tools for working with tasks."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"cfg-target-has-atomic"
	"default"
	"std"
	"unstable"
)
