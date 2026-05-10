# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="openssl-sys"
CRATE_VERSION="0.9.115"
CRATE_CHECKSUM="158fe5b292746440aa6e7a7e690e55aeb72d41505e2804c23c6973ad0e9c9781"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings to OpenSSL"
HOMEPAGE="https://github.com/rust-openssl/rust-openssl"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc"
	"aws-lc-fips"
	"unstable_boringssl"
	"vendored"
)
