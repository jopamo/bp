# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tower"
CRATE_VERSION="0.4.13"
CRATE_CHECKSUM="b8fa9be0de6cf49e536ce1851f987bd21a43b771b09473c3549a6c853db37c1c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tower is a library of modular and reusable components for building robust clients and servers."
HOMEPAGE="https://github.com/tower-rs/tower"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__common"
	"balance"
	"buffer"
	"default"
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
	"util"
)
