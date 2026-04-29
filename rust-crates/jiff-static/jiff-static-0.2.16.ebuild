# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="jiff-static"
CRATE_VERSION="0.2.16"
CRATE_CHECKSUM="980af8b43c3ad5d8d349ace167ec8170839f753a42d233ba19e08afe1850fa69"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Create static TimeZone values for Jiff (useful in core-only environments)."
HOMEPAGE="https://github.com/BurntSushi/jiff/tree/master/crates/jiff-static"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"perf-inline"
	"tz-fat"
	"tzdb"
)
