# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is-docker"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="928bae27f42bc99b60d9ac7334e3a21d10ad8f1835a4e12ec3ec0464765ed1b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Checks if the process is running inside a Docker container."
HOMEPAGE="https://github.com/TheLarkInn/is-docker"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
