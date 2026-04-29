# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="aws-lc-rs"
CRATE_VERSION="1.16.1"
CRATE_CHECKSUM="94bffc006df10ac2a68c83692d734a465f8ee6c5b384d8545a636f81d858f4bf"
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
	"non-fips"
	"prebuilt-nasm"
	"ring-io"
	"ring-sig-verify"
	"test_logging"
	"unstable"
)
