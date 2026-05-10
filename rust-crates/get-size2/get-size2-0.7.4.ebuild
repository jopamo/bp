# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="get-size2"
CRATE_VERSION="0.7.4"
CRATE_CHECKSUM="49cf31a6d70300cf81461098f7797571362387ef4bf85d32ac47eaa59b3a5a1a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine the size in bytes an object occupies inside RAM."
HOMEPAGE="https://github.com/bircni/get-size2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bytes"
	"chrono"
	"chrono-tz"
	"compact-str"
	"default"
	"derive"
	"hashbrown"
	"indexmap"
	"ordermap"
	"smallvec"
	"thin-vec"
	"url"
)
