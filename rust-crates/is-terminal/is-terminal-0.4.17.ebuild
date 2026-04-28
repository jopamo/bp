# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="is-terminal"
CRATE_VERSION="0.4.17"
CRATE_CHECKSUM="3640c1c38b8e4e43584d8df18be5fc6b0aa314ce6ebf51b53313d4306cca8e46"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Test whether a given stream is a terminal"
HOMEPAGE="https://github.com/sunfishcode/is-terminal"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
