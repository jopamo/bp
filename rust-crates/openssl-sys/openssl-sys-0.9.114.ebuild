# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="openssl-sys"
CRATE_VERSION="0.9.114"
CRATE_CHECKSUM="13ce1245cd07fcc4cfdb438f7507b0c7e4f3849a69fd84d52374c66d83741bb6"
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
