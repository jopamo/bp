# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aws-lc-sys"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="0f9dd2e03ee80ca2822dd6ea431163d2ef259f2066a4d6ccaca6d9dcb386aa43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="AWS-LC is a general-purpose cryptographic library maintained by the AWS Cryptography team for AWS and their customers. It іs based on code from the Google BoringSSL project and the OpenSSL project."
HOMEPAGE="https://github.com/aws/aws-lc-rs"
LICENSE="ISC || ( Apache-2.0 ISC ) OpenSSL"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"asan"
	"bindgen"
	"prebuilt-nasm"
	"ssl"
)
