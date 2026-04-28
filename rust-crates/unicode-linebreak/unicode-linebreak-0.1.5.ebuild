# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-linebreak"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="3b09c83c3c29d37506a3e260c08c03743a6bb66a9cd432c6934ab501a190571f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation of the Unicode Line Breaking Algorithm"
HOMEPAGE="https://github.com/axelf4/unicode-linebreak"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
