# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="borsh-derive"
CRATE_VERSION="1.8.1"
CRATE_CHECKSUM="12cdfe656708a01f89b451a7d36466e6fe6c414de0aa18fc54f864f6f9ca9f56"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Binary Object Representation Serializer for Hashing"
HOMEPAGE="https://borsh.io"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"force_exhaustive_checks"
	"schema"
)
