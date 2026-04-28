# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_core"
CRATE_VERSION="1.0.228"
CRATE_CHECKSUM="41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde traits only, with no support for derive -- use the `serde` crate instead"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"rc"
	"result"
	"std"
	"unstable"
)
