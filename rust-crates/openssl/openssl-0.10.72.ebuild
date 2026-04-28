# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl"
CRATE_VERSION="0.10.72"
CRATE_CHECKSUM="fedfea7d58a1f73118430a55da6a286e7b044961736ce96a16a17068ea25e5da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="OpenSSL bindings"
HOMEPAGE="https://github.com/sfackler/rust-openssl"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc"
	"bindgen"
	"default"
	"unstable_boringssl"
	"v101"
	"v102"
	"v110"
	"v111"
	"vendored"
)
