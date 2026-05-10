# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-static"
CRATE_VERSION="0.2.24"
CRATE_CHECKSUM="e000de030ff8022ea1da3f466fbb0f3a809f5e51ed31f6dd931c35181ad8e6d7"
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
