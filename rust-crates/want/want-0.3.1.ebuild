# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="want"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="bfa7760aed19e106de2c7c0b581b509f2f25d3dacaf737cb82ac61bc6d760b0e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Detect when another Future wants a result."
HOMEPAGE="https://github.com/seanmonstar/want"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
