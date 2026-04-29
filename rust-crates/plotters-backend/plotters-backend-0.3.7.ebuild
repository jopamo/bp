# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="plotters-backend"
CRATE_VERSION="0.3.7"
CRATE_CHECKSUM="df42e13c12958a16b3f7f4386b9ab1f3e7933914ecea48da7139435263a4172a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Plotters Backend API"
HOMEPAGE="https://plotters-rs.github.io"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
