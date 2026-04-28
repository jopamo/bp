# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_complete_fig"
CRATE_VERSION="4.5.2"
CRATE_CHECKSUM="d494102c8ff3951810c72baf96910b980fb065ca5d3101243e6a8dc19747c86b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generator library used with clap for Fig completion scripts"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
