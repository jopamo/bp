# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="gif"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="3fb2d69b19215e18bb912fa30f7ce15846e301408695e44e0ef719f1da9e19f2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="GIF de- and encoder"
HOMEPAGE="https://github.com/image-rs/image-gif"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color_quant"
	"default"
	"raii_no_panic"
	"std"
)
