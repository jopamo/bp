# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="borsh"
CRATE_VERSION="1.6.1"
CRATE_CHECKSUM="cfd1e3f8955a5d7de9fab72fc8373fade9fb8a703968cb200ae3dc6cf08e185a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Binary Object Representation Serializer for Hashing"
HOMEPAGE="https://borsh.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"de_strict_order"
	"default"
	"derive"
	"rc"
	"std"
	"unstable__schema"
)
