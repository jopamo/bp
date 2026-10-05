# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_terminal"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="f3ba8041ae7319b3ca6a64c399df4112badcbbe0868b4517637647614bede4be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Terminal styling and other functionality used across Deno"
HOMEPAGE="https://github.com/denoland/deno_terminal"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"colors"
	"default"
)
