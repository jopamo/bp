# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zmij"
CRATE_VERSION="1.0.19"
CRATE_CHECKSUM="3ff05f8caa9038894637571ae6b9e29466c1f4f829d26c9b28f869a29cbe3445"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A double-to-string conversion algorithm based on Schubfach and yy"
HOMEPAGE="https://github.com/dtolnay/zmij"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
