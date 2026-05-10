# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="openssl"
CRATE_VERSION="0.10.79"
CRATE_CHECKSUM="bf0b434746ee2832f4f0baf10137e1cabb18cbe6912c69e2e33263c45250f542"
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
