# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fancy-regex"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="6e24cb5a94bcae1e5408b0effca5cd7172ea3c5755049c5f3af4cd283a165298"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of regexes, supporting a relatively rich set of features, including backreferences and look-around."
HOMEPAGE="https://github.com/fancy-regex/fancy-regex"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"perf"
	"std"
	"track_caller"
	"unicode"
)
