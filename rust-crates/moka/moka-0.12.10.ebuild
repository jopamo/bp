# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="moka"
CRATE_VERSION="0.12.10"
CRATE_CHECKSUM="a9321642ca94a4282428e6ea4af8cc2ca4eac48ac7a6a4ea8f33f76d0ce70926"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast and concurrent cache library inspired by Java Caffeine"
HOMEPAGE="https://github.com/moka-rs/moka"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"atomic64"
	"default"
	"future"
	"logging"
	"quanta"
	"sync"
	"unstable-debug-counters"
)
