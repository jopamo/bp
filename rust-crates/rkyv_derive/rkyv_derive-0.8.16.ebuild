# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rkyv_derive"
CRATE_VERSION="0.8.16"
CRATE_CHECKSUM="5d2ed0b54125315fb36bd021e82d314d1c126548f871634b483f46b31d13cac6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for rkyv"
HOMEPAGE="https://github.com/rkyv/rkyv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bytecheck"
	"default"
)
