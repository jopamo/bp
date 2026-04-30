# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_spanned"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde-compatible spanned Value"
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde"
	"std"
)
