# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="snapbox"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="f92ac911648d788a6435401d9b4803959039d4de9919fdabdb415a8bebd027be"
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
