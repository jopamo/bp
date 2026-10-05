# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ed448-goldilocks"
CRATE_VERSION="0.14.0-pre.10"
CRATE_CHECKSUM="7b5c8e6341702ff3b4d27a1a21c4ad3d38f3b18facc3b94e04f9157bae4089c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A pure-Rust implementation of Ed448 and Curve448 and Decaf. This crate also includes signing and verifying of Ed448 signatures."
HOMEPAGE="https://docs.rs/ed448-goldilocks/"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"bits"
	"default"
	"getrandom"
	"pkcs8"
	"serde"
	"signing"
	"std"
)
