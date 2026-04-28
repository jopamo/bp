# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="env_filter"
CRATE_VERSION="0.1.3"
CRATE_CHECKSUM="186e05a59d4c50738528153b83b0b0194d3a29507dfec16eccd4b342903397d0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Filter log events using environment variables"
HOMEPAGE="https://github.com/rust-cli/env_logger"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"regex"
)
