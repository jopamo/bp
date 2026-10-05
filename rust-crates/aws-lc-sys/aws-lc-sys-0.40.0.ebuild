# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="aws-lc-sys"
CRATE_VERSION="0.40.0"
CRATE_CHECKSUM="f50037ee5e1e41e7b8f9d161680a725bd1626cb6f8c7e901f91f942850852fe7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="AWS-LC is a general-purpose cryptographic library maintained by the AWS Cryptography team for AWS and their customers. It іs based on code from the Google BoringSSL project and the OpenSSL project."
HOMEPAGE="https://github.com/aws/aws-lc-rs"
LICENSE="ISC || ( Apache-2.0 ISC ) Apache-2.0 MIT BSD-3-Clause || ( Apache-2.0 ISC MIT ) || ( Apache-2.0 ISC MIT-0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all-bindings"
	"asan"
	"bindgen"
	"default"
	"disable-prebuilt-nasm"
	"fips"
	"prebuilt-nasm"
	"ssl"
)
