# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff-static"
CRATE_VERSION="0.2.29"
CRATE_CHECKSUM="0666b5ab5ecaca213fc2a85b8c0083d9004e84ee2d5f9a7e0017aaf50986f25f"
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
