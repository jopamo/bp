# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="perf-event"
CRATE_VERSION="0.4.7"
CRATE_CHECKSUM="5396562cd2eaa828445d6d34258ae21ee1eb9d40fe626ca7f51c8dccb4af9d66"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust interface to Linux performance monitoring"
HOMEPAGE="https://github.com/jimblandy/perf-event.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
