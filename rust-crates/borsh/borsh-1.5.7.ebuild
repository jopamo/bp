# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="borsh"
CRATE_VERSION="1.5.7"
CRATE_CHECKSUM="ad8646f98db542e39fc66e68a20b2144f6a732636df7c2354e74645faaa433ce"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Binary Object Representation Serializer for Hashing"
HOMEPAGE="https://borsh.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"de_strict_order"
	"default"
	"derive"
	"rc"
	"std"
	"unstable__schema"
)
