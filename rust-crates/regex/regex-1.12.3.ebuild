# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="regex"
CRATE_VERSION="1.12.3"
CRATE_CHECKSUM="e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of regular expressions for Rust. This implementation uses finite automata and guarantees linear time matching on all inputs."
HOMEPAGE="https://github.com/rust-lang/regex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
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
