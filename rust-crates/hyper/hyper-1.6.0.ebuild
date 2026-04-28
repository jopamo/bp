# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hyper"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="cc2b571658e38e0c01b1fdca3bbbe93c00d3d71693ff2770043f8c29bc7d6f80"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A protective and efficient HTTP library for all."
HOMEPAGE="https://hyper.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"capi"
	"client"
	"default"
	"ffi"
	"full"
	"http1"
	"http2"
	"nightly"
	"server"
	"tracing"
)
