# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_derive"
CRATE_VERSION="4.6.0"
CRATE_CHECKSUM="1110bd8a634a1ab8cb04345d8d878267d57c3cf1b38d91b71af6686408bbca6a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse command line argument by defining a struct, derive crate."
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"deprecated"
	"raw-deprecated"
	"unstable-markdown"
	"unstable-v5"
)
