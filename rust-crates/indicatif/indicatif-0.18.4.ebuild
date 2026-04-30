# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="indicatif"
CRATE_VERSION="0.18.4"
CRATE_CHECKSUM="25470f23803092da7d239834776d653104d551bc4d7eacaf31e6837854b8e9eb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A progress bar and cli reporting library for Rust"
HOMEPAGE="https://github.com/console-rs/indicatif"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures"
	"improved_unicode"
	"in_memory"
	"unicode-width"
	"wasmbind"
)
