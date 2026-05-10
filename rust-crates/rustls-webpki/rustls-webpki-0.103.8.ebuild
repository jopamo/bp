# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustls-webpki"
CRATE_VERSION="0.103.8"
CRATE_CHECKSUM="2ffdfa2f5286e2247234e03f680868ac2815974dc39e00ea15adc445d0aafe52"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Web PKI X.509 Certificate Verification."
HOMEPAGE="https://github.com/rustls/webpki"
LICENSE="ISC"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"aws-lc-rs"
	"aws-lc-rs-fips"
	"aws-lc-rs-unstable"
	"default"
	"ring"
	"std"
)
