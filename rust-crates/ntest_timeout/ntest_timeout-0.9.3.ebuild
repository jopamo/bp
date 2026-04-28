# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ntest_timeout"
CRATE_VERSION="0.9.3"
CRATE_CHECKSUM="fcc7c92f190c97f79b4a332f5e81dcf68c8420af2045c936c9be0bc9de6f63b5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Timeout attribute for the ntest framework."
HOMEPAGE="https://github.com/becheran/ntest"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
