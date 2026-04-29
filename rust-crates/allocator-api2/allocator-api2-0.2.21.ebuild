# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="allocator-api2"
CRATE_VERSION="0.2.21"
CRATE_CHECKSUM="683d7910e743518b0e34f1186f92494becacb047c7b6bf616c96772180fef923"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Mirror of Rust's allocator API"
HOMEPAGE="https://github.com/zakarumych/allocator-api2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"fresh-rust"
	"nightly"
	"std"
)
