# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="postcard"
CRATE_VERSION="1.1.3"
CRATE_CHECKSUM="6764c3b5dd454e283a30e6dfe78e9b31096d9e32036b5d1eaac7a6119ccb9a24"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A no_std + serde compatible message library for Rust"
HOMEPAGE="https://github.com/jamesmunns/postcard"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"core-num-saturating"
	"crc"
	"default"
	"defmt"
	"embedded-io"
	"embedded-io-04"
	"embedded-io-06"
	"experimental-derive"
	"heapless"
	"heapless-cas"
	"nalgebra-v0_33"
	"paste"
	"postcard-derive"
	"use-crc"
	"use-defmt"
	"use-std"
)
