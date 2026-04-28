# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tower"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="d039ad9159c98b70ecfd540b2573b97f7f52c3e8d9f8ad57a24b916a536975f9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tower is a library of modular and reusable components for building robust clients and servers."
HOMEPAGE="https://github.com/tower-rs/tower"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"__common"
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
	"util"
)
