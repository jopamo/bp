# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tinytemplate"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple, lightweight template engine"
HOMEPAGE="https://github.com/bheisler/TinyTemplate"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
