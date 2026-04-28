# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiff"
CRATE_VERSION="0.2.23"
CRATE_CHECKSUM="1a3546dc96b6d42c5f24902af9e2538e82e39ad350b0c766eb3fbf2d8f3d8359"
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
	"default"
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
