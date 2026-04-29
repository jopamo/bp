# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="regex"
CRATE_VERSION="1.12.2"
CRATE_CHECKSUM="843bc0191f75f3e22651ae5f1e72939ab2f72a4bc30fa80a066bd66edefc24d4"
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
