# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-static"
CRATE_VERSION="0.2.35"
CRATE_CHECKSUM="3a69dcb3a21cfb32ce1cd056169337ca284af0766dd766e7878819b251a49204"
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
