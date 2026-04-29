# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="futures-core"
CRATE_VERSION="0.3.32"
CRATE_CHECKSUM="7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The core traits and types in for the \`futures\` library."
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
