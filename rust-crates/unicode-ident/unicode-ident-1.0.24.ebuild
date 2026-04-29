# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unicode-ident"
CRATE_VERSION="1.0.24"
CRATE_CHECKSUM="e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/dtolnay/unicode-ident"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
