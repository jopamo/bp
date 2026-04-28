# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiff"
CRATE_VERSION="0.2.15"
CRATE_CHECKSUM="be1f93b8b1eb69c77f24bbb0afdf66f54b632ee39af40ca21c4365a1d7347e49"
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
