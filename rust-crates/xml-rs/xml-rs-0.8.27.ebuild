# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xml-rs"
CRATE_VERSION="0.8.27"
CRATE_CHECKSUM="6fd8403733700263c6eb89f192880191f1b83e332f7a20371ddcf421c4a337c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An XML library in pure Rust"
HOMEPAGE="https://lib.rs/crates/xml-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
