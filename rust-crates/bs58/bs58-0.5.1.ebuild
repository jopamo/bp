# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bs58"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="bf88ba1141d185c399bee5288d850d63b8369520c1eafc32a0430b5b6c287bf4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Another Base58 codec implementation."
HOMEPAGE="https://github.com/Nullus157/bs58-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"cb58"
	"check"
	"default"
	"std"
)
