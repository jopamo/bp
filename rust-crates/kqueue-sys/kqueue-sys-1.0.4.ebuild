# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="kqueue-sys"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="ed9625ffda8729b85e45cf04090035ac368927b8cebc34898e7c120f52e4838b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Low-level kqueue interface for BSDs"
HOMEPAGE="https://gitlab.com/rust-kqueue/rust-kqueue-sys"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
