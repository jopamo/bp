# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="futures"
CRATE_VERSION="0.3.31"
CRATE_CHECKSUM="65bc07b1a8bc7c85c5f2e110c476c7389b4554ba72af57d8445ea63a576b0876"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of futures and streams featuring zero allocations, composability, and iterator-like interfaces."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"async-await"
	"bilock"
	"cfg-target-has-atomic"
	"compat"
	"default"
	"executor"
	"io-compat"
	"std"
	"thread-pool"
	"unstable"
	"write-all-vectored"
)
