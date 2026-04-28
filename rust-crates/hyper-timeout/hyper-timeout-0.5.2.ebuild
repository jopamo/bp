# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hyper-timeout"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="2b90d566bffbce6a75bd8b09a05aa8c2cb1fabb6cb348f8840c9e4c90a0d83b0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A connect, read and write timeout aware connector to be used with hyper Client."
HOMEPAGE="https://github.com/hjr3/hyper-timeout"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
