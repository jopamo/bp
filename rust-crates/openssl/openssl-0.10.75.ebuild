# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="openssl"
CRATE_VERSION="0.10.75"
CRATE_CHECKSUM="08838db121398ad17ab8531ce9de97b244589089e290a384c900cb9ff7434328"
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
