# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="markdown"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="a5cab8f2cadc416a82d2e783a1946388b31654d391d1c7d92cc1f03e295b1deb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CommonMark compliant markdown parser in Rust with ASTs and extensions"
HOMEPAGE="https://github.com/wooorm/markdown-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"json"
	"log"
	"serde"
)
