# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xml-rs"
CRATE_VERSION="0.8.28"
CRATE_CHECKSUM="3ae8337f8a065cfc972643663ea4279e04e7256de865aa66fe25cec5fb912d3f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An XML library in pure Rust"
HOMEPAGE="https://lib.rs/crates/xml"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
