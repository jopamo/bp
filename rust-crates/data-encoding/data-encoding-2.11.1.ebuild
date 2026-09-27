# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="data-encoding"
CRATE_VERSION="2.11.1"
CRATE_CHECKSUM="4583a4551df46e2792f82ceeac45e850d2e2d5debba0b91f102385cda5b11f06"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Efficient and customizable data-encoding functions like base64, base32, and hex"
HOMEPAGE="https://github.com/ia0/data-encoding"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
