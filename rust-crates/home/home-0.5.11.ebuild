# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="home"
CRATE_VERSION="0.5.11"
CRATE_CHECKSUM="589533453244b0995c858700322199b2becb13b627df2851f64a2775d024abcf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shared definitions of home directories."
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
