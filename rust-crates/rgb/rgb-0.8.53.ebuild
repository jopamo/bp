# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="rgb"
CRATE_VERSION="0.8.53"
CRATE_CHECKSUM="47b34b781b31e5d73e9fbc8689c70551fd1ade9a19e3e28cfec8580a79290cc4"
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
