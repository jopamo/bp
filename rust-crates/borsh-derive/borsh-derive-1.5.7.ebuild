# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="borsh-derive"
CRATE_VERSION="1.5.7"
CRATE_CHECKSUM="fdd1d3c0c2f5833f22386f252fe8ed005c7f59fdcddeef025c01b4c3b9fd9ac3"
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
