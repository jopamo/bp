# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="tower"
CRATE_VERSION="0.5.3"
CRATE_CHECKSUM="ebe5ef63511595f1344e2d5cfa636d973292adc0eec1f0ad45fae9f0851ab1d4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tower is a library of modular and reusable components for building robust clients and servers."
HOMEPAGE="https://github.com/tower-rs/tower"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"balance"
	"buffer"
	"discover"
	"filter"
	"full"
	"hedge"
	"limit"
	"load"
	"load-shed"
	"log"
	"make"
	"ready-cache"
	"reconnect"
	"retry"
	"spawn-ready"
	"steer"
	"timeout"
	"tokio-stream"
	"util"
)
