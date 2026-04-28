# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="opaque-debug"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="c08d65885ee38876c4f86fa503fb49d7b507c2b62552df7c70b2fce627e06381"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for opaque Debug trait implementation"
HOMEPAGE="https://github.com/RustCrypto/utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
