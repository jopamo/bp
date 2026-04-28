# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="utf16_iter"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="c8232dd3cdaed5356e0f716d285e4b40b932ac434100fe9b7e0e8e935b9e6246"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Iterator by char over potentially-invalid UTF-16 in &[u16]"
HOMEPAGE="https://docs.rs/utf16_iter/"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
