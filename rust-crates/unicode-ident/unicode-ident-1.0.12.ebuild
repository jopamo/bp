# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unicode-ident"
CRATE_VERSION="1.0.12"
CRATE_CHECKSUM="3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/dtolnay/unicode-ident"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-DFS-2016"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
