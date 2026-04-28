# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="piper"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="96c8c490f422ef9a4efd2cb5b42b76c8613d7e7dfc1caf667b8a3350a5acc066"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Async pipes, channels, mutexes, and more."
HOMEPAGE="https://github.com/smol-rs/piper"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"portable-atomic"
	"std"
)
