# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="v8_valueserializer"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="97599c400fc79925922b58303e98fcb8fa88f573379a08ddb652e72cbd2e70f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of V8's ValueSerializer and ValueDeserializer"
HOMEPAGE="https://github.com/denoland/v8_valueserializer"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
