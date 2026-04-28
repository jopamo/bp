# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="snapbox"
CRATE_VERSION="0.6.24"
CRATE_CHECKSUM="6c1abc378119f77310836665f8523018532cf7e3faeb3b10b01da5a7321bf8e1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Snapshot testing toolbox"
HOMEPAGE="https://github.com/assert-rs/snapbox/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cmd"
	"color"
	"color-auto"
	"debug"
	"default"
	"detect-encoding"
	"diff"
	"dir"
	"examples"
	"json"
	"path"
	"regex"
	"structured-data"
	"term-svg"
)
