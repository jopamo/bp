# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_urlencoded"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="d3491c14715ca2294c4d6a88f15e84739788c1d030eed8c110436aafdaa2f3fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`x-www-form-urlencoded\` meets Serde"
HOMEPAGE="https://github.com/nox/serde_urlencoded"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
