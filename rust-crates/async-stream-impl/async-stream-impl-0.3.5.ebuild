# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="async-stream-impl"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="16e62a023e7c117e27523144c5d2459f4397fcc3cab0085af8e2224f643a0193"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="proc macros for async-stream crate"
HOMEPAGE="https://github.com/tokio-rs/async-stream"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
