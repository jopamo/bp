# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="typenum"
CRATE_VERSION="1.19.0"
CRATE_CHECKSUM="562d481066bde0658276a35467c4af00bdc6ee726305698a55b86e61d7ad82bb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Typenum is a Rust library for type-level numbers evaluated at compile time. It currently supports bits, unsigned integers, and signed integers. It also provides a type-level array of type-level numbers, but its implementation is incomplete."
HOMEPAGE="https://github.com/paholg/typenum"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const-generics"
	"force_unix_path_separator"
	"i128"
	"no_std"
	"scale_info"
	"strict"
)
