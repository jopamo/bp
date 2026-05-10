# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_core"
CRATE_VERSION="1.0.223"
CRATE_CHECKSUM="20f57cbd357666aa7b3ac84a90b4ea328f1d4ddb6772b430caa5d9e1309bb9e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde traits only, with no support for derive -- use the \`serde\` crate instead"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"rc"
	"result"
	"std"
	"unstable"
)
