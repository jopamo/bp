# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unicode-ident"
CRATE_VERSION="1.0.19"
CRATE_CHECKSUM="f63a545481291138910575129486daeaf8ac54aee4387fe7906919f7830c7d9d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the XID_Start or XID_Continue properties according to Unicode Standard Annex #31"
HOMEPAGE="https://github.com/dtolnay/unicode-ident"
LICENSE="|| ( MIT Apache-2.0 ) Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
