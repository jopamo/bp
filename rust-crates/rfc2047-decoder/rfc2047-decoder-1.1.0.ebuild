# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rfc2047-decoder"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="504ea008279c473dfeafce327fa26bf8825463cfcc06ef82f866187e81334d16"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust library for decoding RFC 2047 MIME Message Headers."
HOMEPAGE="https://github.com/TornaxO7/rfc2047-decoder"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
