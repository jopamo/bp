# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-ident"
CRATE_VERSION="1.0.27"
CRATE_CHECKSUM="a2c754d6c33795a1c324727428e5a7dedb5b06195f9890bdbcba760d3e246563"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/dtolnay/unicode-ident"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
