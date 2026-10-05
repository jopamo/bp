# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_error"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="bfafd2219b29886a71aecbb3449e462deed1b2c474dc5b12f855f0e58c478931"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Error representation to JavaScript for deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
