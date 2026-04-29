# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="futures"
CRATE_VERSION="0.3.32"
CRATE_CHECKSUM="8b147ee9d1f6d097cef9ce628cd2ee62288d963e16fb287bd9286455b241382d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of futures and streams featuring zero allocations, composability, and iterator-like interfaces."
HOMEPAGE="https://rust-lang.github.io/futures-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
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
	"spin"
	"std"
	"thread-pool"
	"unstable"
	"write-all-vectored"
)
