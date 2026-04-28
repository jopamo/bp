# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="simd-json"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="05f0b376aada35f30a0012f5790e50aed62f91804a0682669aefdbe81c7fcb91"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="High performance JSON parser based on a port of simdjson"
HOMEPAGE="https://github.com/simd-lite/simd-json"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"128bit"
	"alloc"
	"approx-number-parsing"
	"arraybackend"
	"bench-all"
	"bench-apache_builds"
	"bench-canada"
	"bench-citm_catalog"
	"bench-event_stacktrace_10kb"
	"bench-github_events"
	"bench-log"
	"bench-serde"
	"bench-twitter"
	"big-int-as-float"
	"default"
	"docsrs"
	"hints"
	"known-key"
	"no-inline"
	"perf"
	"runtime-detection"
	"serde_impl"
	"swar-number-parsing"
	"value-no-dup-keys"
)
