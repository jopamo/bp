# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xcursor"
CRATE_VERSION="0.3.10"
CRATE_CHECKSUM="bec9e4a500ca8864c5b47b8b482a73d62e4237670e5b5f1d6b9e3cae50f28f2b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for loading XCursor themes"
HOMEPAGE="https://github.com/esposm03/xcursor-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
