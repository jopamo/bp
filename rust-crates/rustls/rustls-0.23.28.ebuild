# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls"
CRATE_VERSION="0.23.28"
CRATE_CHECKSUM="7160e3e10bf4535308537f3c4e1641468cd0e485175d6163087c0393c7d46643"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustls is a modern TLS library written in Rust."
HOMEPAGE="https://github.com/rustls/rustls"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aws-lc-rs"
	"aws_lc_rs"
	"brotli"
	"custom-provider"
	"default"
	"fips"
	"logging"
	"prefer-post-quantum"
	"read_buf"
	"ring"
	"std"
	"tls12"
	"zlib"
)
