# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="signal-hook"
CRATE_VERSION="0.3.18"
CRATE_CHECKSUM="d881a16cf4426aa584979d30bd82cb33429027e42122b169753d6ef1085ed6e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unix signal handling"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"channel"
	"default"
	"extended-siginfo"
	"extended-siginfo-raw"
	"iterator"
)
