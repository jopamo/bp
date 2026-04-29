# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regex-syntax"
CRATE_VERSION="0.8.5"
CRATE_CHECKSUM="2b15c43186be67a4fd63bee50d0303afffcef381492ebe2c5d87f324e1b8815c"
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
