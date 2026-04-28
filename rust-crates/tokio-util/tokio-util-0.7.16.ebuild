# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tokio-util"
CRATE_VERSION="0.7.16"
CRATE_CHECKSUM="14307c986784f72ef81c89db7d9e28d6ac26d16213b109ea501696195e6e3ce5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Additional utilities for working with Tokio."
HOMEPAGE="https://tokio.rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__docs_rs"
	"codec"
	"compat"
	"default"
	"full"
	"io"
	"io-util"
	"join-map"
	"net"
	"rt"
	"time"
)
