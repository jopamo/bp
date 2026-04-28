# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="textwrap"
CRATE_VERSION="0.16.2"
CRATE_CHECKSUM="c13547615a44dc9c452a8a534638acdf07120d4b6847c8178705da06306a3057"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for word wrapping, indenting, and dedenting strings. Has optional support for Unicode and emojis as well as machine hyphenation."
HOMEPAGE="https://github.com/mgeisler/textwrap"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
