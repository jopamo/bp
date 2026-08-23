# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="derive-where"
CRATE_VERSION="1.6.1"
CRATE_CHECKSUM="d08b3a0bcc0d079199cd476b2cae8435016ec11d1c0986c6901c5ac223041534"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Deriving with custom trait bounds"
HOMEPAGE="https://github.com/ModProg/derive-where"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
	"safe"
	"serde"
	"zeroize"
	"zeroize-on-drop"
)
