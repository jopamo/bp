# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dtoa-short"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="cd1511a7b6a56299bd043a9c167a6d2bfb37bf84a6dfceaba651168adfb43c87"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serialize float number and truncate to certain precision"
HOMEPAGE="https://github.com/upsuper/dtoa-short"
LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
