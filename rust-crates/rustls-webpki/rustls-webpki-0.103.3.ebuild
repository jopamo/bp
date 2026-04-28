# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-webpki"
CRATE_VERSION="0.103.3"
CRATE_CHECKSUM="e4a72fe2bcf7a6ac6fd7d0b9e5cb68aeb7d4c0a0271730218b3e92d43b4eb435"
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
	"default"
	"ring"
	"std"
)
