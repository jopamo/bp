# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jiff"
CRATE_VERSION="0.2.37"
CRATE_CHECKSUM="0ab1baf72f08796de0260609515130699b890ac25f30e610ad894bc5856cafdb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A date-time library that encourages you to jump into the pit of success. This library is heavily inspired by the Temporal project."
HOMEPAGE="https://github.com/BurntSushi/jiff"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"arbitrary"
	"default"
	"defmt"
	"js"
	"logging"
	"perf-inline"
	"serde"
	"static"
	"static-tz"
	"std"
	"tz-fat"
	"tz-system"
	"tzdb-bundle-always"
	"tzdb-bundle-platform"
	"tzdb-concatenated"
	"tzdb-zoneinfo"
)
