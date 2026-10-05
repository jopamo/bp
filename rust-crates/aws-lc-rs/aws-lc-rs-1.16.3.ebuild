# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="aws-lc-rs"
CRATE_VERSION="1.16.3"
CRATE_CHECKSUM="0ec6fb3fe69024a75fa7e1bfb48aa6cf59706a101658ea01bfd33b2b248a038f"
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
