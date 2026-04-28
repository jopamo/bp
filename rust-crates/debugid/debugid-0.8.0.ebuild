# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="debugid"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="bef552e6f588e446098f6ba40d89ac146c8c7b64aade83c051ee00bb5d2bc18d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common reusable types for implementing the sentry.io protocol."
HOMEPAGE="https://sentry.io/"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
