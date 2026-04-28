# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regex"
CRATE_VERSION="1.10.6"
CRATE_CHECKSUM="4219d74c6b67a3654a9fbebc4b419e22126d13d2f3c4a07ee0cb61ff79a79619"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of regular expressions for Rust. This implementation uses finite automata and guarantees linear time matching on all inputs."
HOMEPAGE="https://github.com/rust-lang/regex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"logging"
	"pattern"
	"perf"
	"perf-backtrack"
	"perf-cache"
	"perf-dfa"
	"perf-dfa-full"
	"perf-inline"
	"perf-literal"
	"perf-onepass"
	"std"
	"unicode"
	"unicode-age"
	"unicode-bool"
	"unicode-case"
	"unicode-gencat"
	"unicode-perl"
	"unicode-script"
	"unicode-segment"
	"unstable"
	"use_std"
)
