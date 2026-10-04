# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="base64"
CRATE_VERSION="0.23.1"
CRATE_CHECKSUM="ac07cdecf99051d9a5238b80f35af32cdeba5b336e55d957b318b50137e18da5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="encodes and decodes base64 as bytes or utf8"
HOMEPAGE="https://github.com/marshallpierce/rust-base64"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"simd-unsafe"
	"std"
)
