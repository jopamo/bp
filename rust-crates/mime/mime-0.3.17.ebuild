# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mime"
CRATE_VERSION="0.3.17"
CRATE_CHECKSUM="6877bb514081ee2a7ff5ef9de3281f14a4dd4bceac4c09388074a6b5df8a139a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Strongly Typed Mimes"
HOMEPAGE="https://github.com/hyperium/mime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
