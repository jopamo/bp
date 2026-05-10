# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="arcstr"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="03918c3dbd7701a85c6b9887732e2921175f26c350b4563841d0958c21d57e6d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A better reference-counted string type, with zero-cost (allocation-free) support for string literals, and reference counted substrings."
HOMEPAGE="https://github.com/thomcc/arcstr"
LICENSE="|| ( Apache-2.0 MIT Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"substr"
	"substr-usize-indices"
)
