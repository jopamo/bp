# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="weezl"
CRATE_VERSION="0.1.10"
CRATE_CHECKSUM="a751b3277700db47d3e574514de2eced5e54dc8a5436a3bf7a0b248b2cee16f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast LZW compression and decompression."
HOMEPAGE="https://github.com/image-rs/weezl"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"async"
	"default"
	"std"
)
