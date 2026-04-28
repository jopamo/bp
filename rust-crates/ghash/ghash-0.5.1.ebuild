# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ghash"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="f0d8a4362ccb29cb0b265253fb0a2728f592895ee6854fd9bc13f2ffda266ff1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Universal hash over GF(2^128) useful for constructing a Message Authentication Code (MAC), as in the AES-GCM authenticated encryption cipher."
HOMEPAGE="https://github.com/RustCrypto/universal-hashes"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"std"
)
