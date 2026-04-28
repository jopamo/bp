# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glutin_glx_sys"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="8a7bb2938045a88b612499fbcba375a77198e01306f52272e692f8c1f3751185"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The glx bindings for glutin"
HOMEPAGE="https://github.com/rust-windowing/glutin"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
