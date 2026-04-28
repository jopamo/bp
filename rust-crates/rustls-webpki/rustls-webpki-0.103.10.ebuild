# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-webpki"
CRATE_VERSION="0.103.10"
CRATE_CHECKSUM="df33b2b81ac578cabaf06b89b0631153a3f416b0a886e8a7a1707fb51abbd1ef"
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
