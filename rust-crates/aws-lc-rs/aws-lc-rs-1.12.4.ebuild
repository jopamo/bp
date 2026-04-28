# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aws-lc-rs"
CRATE_VERSION="1.12.4"
CRATE_CHECKSUM="4cd755adf9707cf671e31d944a189be3deaaeee11c8bc1d669bb8022ac90fbd0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="aws-lc-rs is a cryptographic library using AWS-LC for its cryptographic operations. This library strives to be API-compatible with the popular Rust library named ring."
HOMEPAGE="https://github.com/aws/aws-lc-rs"
LICENSE="ISC || ( Apache-2.0 ISC )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"asan"
	"bindgen"
	"default"
	"fips"
	"non-fips"
	"prebuilt-nasm"
	"ring-io"
	"ring-sig-verify"
	"test_logging"
	"unstable"
)
