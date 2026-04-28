# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regex-syntax"
CRATE_VERSION="0.8.10"
CRATE_CHECKSUM="dc897dd8d9e8bd1ed8cdad82b5966c3e0ecae09fb1907d58efaa013543185d0a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A regular expression parser."
HOMEPAGE="https://github.com/rust-lang/regex/tree/master/regex-syntax"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
