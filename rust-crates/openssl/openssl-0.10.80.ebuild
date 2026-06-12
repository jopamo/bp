# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="openssl"
CRATE_VERSION="0.10.80"
CRATE_CHECKSUM="a45fa2aa886c42762255da344f0a0d313e254066c46aad76f300c3d3da62d967"
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
