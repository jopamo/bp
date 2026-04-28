# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_derive"
CRATE_VERSION="4.5.47"
CRATE_CHECKSUM="bbfd7eae0b0f1a6e63d4b13c9c478de77c2eb546fba158ad50b4203dc24b9f9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse command line argument by defining a struct, derive crate."
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"deprecated"
	"raw-deprecated"
	"unstable-markdown"
	"unstable-v5"
)
