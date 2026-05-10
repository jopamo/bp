# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rgb"
CRATE_VERSION="0.8.52"
CRATE_CHECKSUM="0c6a884d2998352bb4daf0183589aec883f16a6da1f4dde84d8e2e9a5409a1ce"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`struct RGB/RGBA/etc.\` for sharing pixels between crates + convenience methods for color manipulation. Allows no-copy high-level interoperability. Also adds common convenience methods and implements standard Rust traits to make \`RGB\`/\`RGBA\` pixels and slices first-class Rust objects."
HOMEPAGE="https://lib.rs/crates/rgb"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"argb"
	"as-bytes"
	"bytemuck"
	"checked_fns"
	"default"
	"defmt-03"
	"grb"
	"serde"
	"unstable-experimental"
)
