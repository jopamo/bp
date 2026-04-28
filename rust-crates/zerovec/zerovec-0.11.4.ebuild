# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerovec"
CRATE_VERSION="0.11.4"
CRATE_CHECKSUM="e7aa2bd55086f1ab526693ecbe444205da57e25f4489879da80635a46d90e73b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Zero-copy vector backed by a byte array"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"derive"
	"hashmap"
	"serde"
	"std"
	"yoke"
)
