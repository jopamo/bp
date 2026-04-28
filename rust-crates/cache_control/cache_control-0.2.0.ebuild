# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cache_control"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="1bf2a5fb3207c12b5d208ebc145f967fea5cac41a021c37417ccc31ba40f39ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust crate to parse the HTTP Cache-Control header."
HOMEPAGE="https://github.com/connerebbinghaus/rust-cache-control"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
