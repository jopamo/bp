# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="openssl"
CRATE_VERSION="0.10.78"
CRATE_CHECKSUM="f38c4372413cdaaf3cc79dd92d29d7d9f5ab09b51b10dded508fb90bb70b9222"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OpenSSL bindings"
HOMEPAGE="https://github.com/rust-openssl/rust-openssl"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc"
	"aws-lc-fips"
	"bindgen"
	"default"
	"unstable_boringssl"
	"v101"
	"v102"
	"v110"
	"v111"
	"vendored"
)
