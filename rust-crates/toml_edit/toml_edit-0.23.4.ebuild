# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="toml_edit"
CRATE_VERSION="0.23.4"
CRATE_CHECKSUM="7211ff1b8f0d3adae1663b7da9ffe396eabe1ca25f0b0bee42b0da29a9ddce93"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Yet another format-preserving TOML parser."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"display"
	"parse"
	"serde"
	"unbounded"
)
