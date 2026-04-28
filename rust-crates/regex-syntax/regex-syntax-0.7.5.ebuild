# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regex-syntax"
CRATE_VERSION="0.7.5"
CRATE_CHECKSUM="dbb5fb1acd8a1a18b3dd5be62d25485eb770e05afb408a9627d14d451bae12da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A regular expression parser."
HOMEPAGE="https://github.com/rust-lang/regex/tree/master/regex-syntax"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"std"
	"unicode"
	"unicode-age"
	"unicode-bool"
	"unicode-case"
	"unicode-gencat"
	"unicode-perl"
	"unicode-script"
	"unicode-segment"
)
