# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="aws-lc-sys"
CRATE_VERSION="0.38.0"
CRATE_CHECKSUM="4321e568ed89bb5a7d291a7f37997c2c0df89809d7b6d12062c81ddb54aa782e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="AWS-LC is a general-purpose cryptographic library maintained by the AWS Cryptography team for AWS and their customers. It іs based on code from the Google BoringSSL project and the OpenSSL project."
HOMEPAGE="https://github.com/aws/aws-lc-rs"
LICENSE="ISC || ( Apache-2.0 ISC ) OpenSSL"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all-bindings"
	"asan"
	"bindgen"
	"default"
	"disable-prebuilt-nasm"
	"prebuilt-nasm"
	"ssl"
)
