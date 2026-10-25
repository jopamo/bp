# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="aws-lc-rs"
CRATE_VERSION="1.18.2"
CRATE_CHECKSUM="faac5829c2b74c28f830747e7818ccfb684261b5f48a1118b1e2a13d36dfab13"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="aws-lc-rs is a cryptographic library using AWS-LC for its cryptographic operations. This library strives to be API-compatible with the popular Rust library named ring."
HOMEPAGE="https://github.com/aws/aws-lc-rs"
LICENSE="ISC || ( Apache-2.0 ISC )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"asan"
	"bindgen"
	"default"
	"dev-tests-only"
	"fips"
	"legacy-des"
	"non-fips"
	"prebuilt-nasm"
	"ring-io"
	"ring-sig-verify"
	"test_logging"
	"unstable"
)
