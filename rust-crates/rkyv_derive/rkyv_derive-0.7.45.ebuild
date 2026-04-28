# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rkyv_derive"
CRATE_VERSION="0.7.45"
CRATE_CHECKSUM="503d1d27590a2b0a3a4ca4c94755aa2875657196ecbf401a42eff41d7de532c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for rkyv"
HOMEPAGE="https://github.com/rkyv/rkyv"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"arbitrary_enum_discriminant"
	"archive_be"
	"archive_le"
	"copy"
	"default"
	"strict"
)
