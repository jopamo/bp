# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="encoding"
CRATE_VERSION="0.2.33"
CRATE_CHECKSUM="6b0d943856b990d12d3b55b359144ff341533e516d94098b1d3fc1ac666d36ec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Character encoding support for Rust"
HOMEPAGE="https://github.com/lifthrasiir/rust-encoding"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
