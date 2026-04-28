# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lazy-regex"
CRATE_VERSION="3.1.0"
CRATE_CHECKSUM="5d12be4595afdf58bd19e4a9f4e24187da2a66700786ff660a418e9059937a4c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="lazy static regular expressions checked at compile time"
HOMEPAGE="https://github.com/Canop/lazy-regex"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"lite"
	"perf"
	"perf-cache"
	"perf-dfa"
	"perf-inline"
	"perf-literal"
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
