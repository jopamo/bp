# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-width"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="1fc81956842c57dac11422a97c3b8195a1ff727f06e85c84ed2e8aa277c9a0fd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine displayed width of `char` and `str` types according to Unicode Standard Annex #11 rules."
HOMEPAGE="https://github.com/unicode-rs/unicode-width"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cjk"
	"default"
	"no_std"
	"rustc-dep-of-std"
)
