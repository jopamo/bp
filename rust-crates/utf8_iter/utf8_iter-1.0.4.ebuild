# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="utf8_iter"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Iterator by char over potentially-invalid UTF-8 in &[u8]"
HOMEPAGE="https://docs.rs/utf8_iter/"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
