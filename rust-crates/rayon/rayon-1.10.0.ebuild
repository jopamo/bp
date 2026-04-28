# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rayon"
CRATE_VERSION="1.10.0"
CRATE_CHECKSUM="b418a60154510ca1a002a752ca9714984e21e4241e804d32555251faf8b78ffa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Simple work-stealing parallelism for Rust"
HOMEPAGE="https://github.com/rayon-rs/rayon"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"web_spin_lock"
)
