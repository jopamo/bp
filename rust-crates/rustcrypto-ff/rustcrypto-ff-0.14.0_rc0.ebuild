# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustcrypto-ff"
CRATE_VERSION="0.14.0-rc.0"
CRATE_CHECKSUM="c5db129183b2c139d7d87d08be57cba626c715789db17aec65c8866bfd767d1f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for building and interfacing with finite fields"
HOMEPAGE="https://github.com/RustCrypto/ff"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"bits"
	"default"
	"derive"
	"std"
)
