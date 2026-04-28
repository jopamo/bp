# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="autocfg"
CRATE_VERSION="0.1.8"
CRATE_CHECKSUM="0dde43e75fd43e8a1bf86103336bc699aa8d17ad1be60c76c0bdfd4828e19b78"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatic cfg for Rust compiler features"
HOMEPAGE="https://github.com/cuviper/autocfg"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
