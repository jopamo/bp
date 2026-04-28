# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="urlpattern"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="70acd30e3aa1450bc2eece896ce2ad0d178e9c079493819301573dae3c37ba6d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rust-urlpattern is a Rust implementation of the URLPattern standard"
HOMEPAGE="https://github.com/denoland/rust-urlpattern"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
