# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="textwrap"
CRATE_VERSION="0.16.3"
CRATE_CHECKSUM="b81c0cb5fce14f53e49c1d4da0c508334ff12040221bb8ab01b2dabd91d04b6e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for word wrapping, indenting, and dedenting strings. Has optional support for Unicode and emojis as well as machine hyphenation."
HOMEPAGE="https://github.com/mgeisler/textwrap"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"hyphenation"
	"smawk"
	"std"
	"terminal_size"
	"unicode-linebreak"
	"unicode-linebreak-complex"
	"unicode-width"
)
