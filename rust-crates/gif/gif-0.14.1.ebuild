# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="gif"
CRATE_VERSION="0.14.1"
CRATE_CHECKSUM="f5df2ba84018d80c213569363bdcd0c64e6933c67fe4c1d60ecf822971a3c35e"
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
