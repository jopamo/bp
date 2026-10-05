# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_doc"
CRATE_VERSION="0.207.0"
CRATE_CHECKSUM="3be16593d05e9f94267702f8c45adf0b5d335c584e5f0637238ba73f474282f8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="doc generation for deno"
HOMEPAGE="https://github.com/denoland/deno_doc"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rust"
)
