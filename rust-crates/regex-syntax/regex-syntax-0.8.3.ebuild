# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regex-syntax"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="adad44e29e4c806119491a7f06f03de4d1af22c3a680dd47f1e6e179439d1f56"
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
