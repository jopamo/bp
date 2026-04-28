# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_with"
CRATE_VERSION="3.14.1"
CRATE_CHECKSUM="c522100790450cf78eeac1507263d0a350d4d5b30df0c8e1fe051a10c22b376e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom de/serialization functions for Rust's serde"
HOMEPAGE="https://github.com/jonasbb/serde_with/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"base64"
	"chrono"
	"chrono_0_4"
	"default"
	"guide"
	"hashbrown_0_14"
	"hashbrown_0_15"
	"hex"
	"indexmap"
	"indexmap_1"
	"indexmap_2"
	"json"
	"macros"
	"schemars_0_8"
	"schemars_0_9"
	"schemars_1"
	"std"
	"time_0_3"
)
