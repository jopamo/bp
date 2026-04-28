# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pkg-config"
CRATE_VERSION="0.3.32"
CRATE_CHECKSUM="7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to run the pkg-config system tool at build time in order to be used in Cargo build scripts."
HOMEPAGE="https://github.com/rust-lang/pkg-config-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
