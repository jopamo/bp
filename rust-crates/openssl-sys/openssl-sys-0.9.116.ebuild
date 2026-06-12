# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="openssl-sys"
CRATE_VERSION="0.9.116"
CRATE_CHECKSUM="f28a22dc7140cda5f096e5e7724a6962ca81a7f8bfd2979f9b18c11af56318c4"
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
