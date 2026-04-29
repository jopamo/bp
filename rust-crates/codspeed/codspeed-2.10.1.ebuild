# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="codspeed"
CRATE_VERSION="2.10.1"
CRATE_CHECKSUM="93f4cce9c27c49c4f101fffeebb1826f41a9df2e7498b7cd4d95c0658b796c6c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core instrumentation library for CodSpeed"
HOMEPAGE="https://codspeed.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
