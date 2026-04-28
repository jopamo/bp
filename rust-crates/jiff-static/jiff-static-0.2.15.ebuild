# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiff-static"
CRATE_VERSION="0.2.15"
CRATE_CHECKSUM="03343451ff899767262ec32146f6d559dd759fdadf42ff0e227c7c48f72594b4"
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
