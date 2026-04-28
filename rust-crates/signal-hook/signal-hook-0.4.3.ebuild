# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="signal-hook"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="3b57709da74f9ff9f4a27dce9526eec25ca8407c45a7887243b031a58935fb8e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unix signal handling"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"channel"
	"default"
	"extended-siginfo"
	"extended-siginfo-raw"
	"iterator"
)
