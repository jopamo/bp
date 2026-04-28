# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="signal-hook"
CRATE_VERSION="0.3.17"
CRATE_CHECKSUM="8621587d4798caf8eb44879d42e56b9a93ea5dcd315a6487c357130095b62801"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unix signal handling"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"channel"
	"default"
	"extended-siginfo"
	"extended-siginfo-raw"
	"iterator"
)
