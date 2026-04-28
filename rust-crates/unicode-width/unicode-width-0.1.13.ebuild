# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-width"
CRATE_VERSION="0.1.13"
CRATE_CHECKSUM="0336d538f7abc86d282a4189614dfaa90810dfc2c6f6427eaf88e16311dd225d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine displayed width of `char` and `str` types according to Unicode Standard Annex #11 rules."
HOMEPAGE="https://github.com/unicode-rs/unicode-width"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"no_std"
	"rustc-dep-of-std"
)
