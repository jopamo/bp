# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="boxed_error"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="17d4f95e880cfd28c4ca5a006cf7f6af52b4bcb7b5866f573b2faa126fb7affb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for easily boxing an error"
HOMEPAGE="https://github.com/denoland/boxed_error"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
