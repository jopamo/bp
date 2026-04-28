# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unicode-width"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="b4ac048d71ede7ee76d585517add45da530660ef4390e49b098733c6e897f254"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine displayed width of `char` and `str` types according to Unicode Standard Annex #11 rules."
HOMEPAGE="https://github.com/unicode-rs/unicode-width"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"cjk"
	"default"
	"no_std"
	"rustc-dep-of-std"
)
