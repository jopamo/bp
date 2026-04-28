# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasite"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="b8dad83b4f25e74f184f64c43b150b91efe7647395b42289f38e50566d82855b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="WASI Terminal Environment API"
HOMEPAGE="https://github.com/ardaku/wasite/blob/stable/CHANGELOG.md"
LICENSE="|| ( Apache-2.0 BSL-1.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
