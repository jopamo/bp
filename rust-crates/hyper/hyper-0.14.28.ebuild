# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hyper"
CRATE_VERSION="0.14.28"
CRATE_CHECKSUM="bf96e135eb83a2a8ddf766e426a841d8ddd7449d5f00d34ea02b41d2f19eef80"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast and correct HTTP library."
HOMEPAGE="https://hyper.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"__internal_happy_eyeballs_tests"
	"backports"
	"client"
	"default"
	"deprecated"
	"ffi"
	"full"
	"http1"
	"http2"
	"nightly"
	"runtime"
	"server"
	"stream"
	"tcp"
)
