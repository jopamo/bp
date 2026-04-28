# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dpi"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="d8b14ccef22fc6f5a8f4d7d768562a182c04ce9a3b3157b91390b52ddfdf1a76"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types for handling UI scaling"
HOMEPAGE="https://github.com/rust-windowing/winit"
LICENSE="Apache-2.0 MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"mint"
	"serde"
	"std"
)
