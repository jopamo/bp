# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="toml_edit"
CRATE_VERSION="0.25.15+spec-1.1.0"
CRATE_CHECKSUM="1340ea94a5856333492c9064b02c778b191dd2c853778d9609debdcdfea3a614"
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
