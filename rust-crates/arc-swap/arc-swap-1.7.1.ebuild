# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="arc-swap"
CRATE_VERSION="1.7.1"
CRATE_CHECKSUM="69f7f8c3906b62b754cd5326047894316021dcfe5a194c8ea52bdd94934a3457"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Atomically swappable Arc"
HOMEPAGE="https://github.com/vorner/arc-swap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental-strategies"
	"experimental-thread-local"
	"internal-test-strategies"
	"weak"
)
