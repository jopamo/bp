# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls"
CRATE_VERSION="0.23.36"
CRATE_CHECKSUM="c665f33d38cea657d9614f766881e4d510e0eda4239891eea56b4cadcf01801b"
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
