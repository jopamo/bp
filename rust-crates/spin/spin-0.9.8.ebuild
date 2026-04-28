# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="spin"
CRATE_VERSION="0.9.8"
CRATE_CHECKSUM="6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Spin-based synchronization primitives"
HOMEPAGE="https://github.com/mvdnes/spin-rs.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"barrier"
	"default"
	"fair_mutex"
	"lazy"
	"lock_api"
	"mutex"
	"once"
	"portable_atomic"
	"rwlock"
	"spin_mutex"
	"std"
	"ticket_mutex"
	"use_ticket_mutex"
)
