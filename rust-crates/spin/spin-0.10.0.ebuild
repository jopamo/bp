# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="spin"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="d5fe4ccb98d9c292d56fec89a5e07da7fc4cf0dc11e156b41793132775d3e591"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Spin-based synchronization primitives"
HOMEPAGE="https://github.com/mvdnes/spin-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"barrier"
	"default"
	"fair_mutex"
	"lazy"
	"lock_api"
	"mutex"
	"once"
	"portable-atomic"
	"portable_atomic"
	"rwlock"
	"spin_mutex"
	"std"
	"ticket_mutex"
	"use_ticket_mutex"
)
