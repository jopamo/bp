# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xml-rs"
CRATE_VERSION="0.8.20"
CRATE_CHECKSUM="791978798f0597cfc70478424c2b4fdc2b7a8024aaff78497ef00f24ef674193"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An XML library in pure Rust"
HOMEPAGE="https://lib.rs/crates/xml-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
