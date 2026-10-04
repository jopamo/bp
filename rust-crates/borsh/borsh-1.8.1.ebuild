# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="borsh"
CRATE_VERSION="1.8.1"
CRATE_CHECKSUM="553c5d846a6ba5150c65e3b1b8ec073bcf1abc20f9b7220de384a4443ea4e20a"
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
