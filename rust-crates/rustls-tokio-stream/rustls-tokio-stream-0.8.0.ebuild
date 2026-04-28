# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-tokio-stream"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="0560d12c0d8c672f849197de91b9ee61f5bf9aa024c97aaeeb112ec2f6c347fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="AsyncRead/AsyncWrite interface for RustTLS on Tokio"
HOMEPAGE="https://github.com/denoland/rustls-tokio-stream"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"trace"
)
