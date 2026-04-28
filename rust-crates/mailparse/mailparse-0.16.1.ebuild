# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mailparse"
CRATE_VERSION="0.16.1"
CRATE_CHECKSUM="60819a97ddcb831a5614eb3b0174f3620e793e97e09195a395bfa948fd68ed2f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple parser for MIME e-mail messages"
HOMEPAGE="https://github.com/staktrace/mailparse/blob/master/README.md"
LICENSE="0BSD"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
