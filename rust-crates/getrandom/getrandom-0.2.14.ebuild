# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="getrandom"
CRATE_VERSION="0.2.14"
CRATE_CHECKSUM="94b22e06ecb0110981051723910cbf0b5f5e09a2062dd7663334ee79a9d1286c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A small cross-platform library for retrieving random data from system source"
HOMEPAGE="https://github.com/rust-random/getrandom"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"custom"
	"js"
	"linux_disable_fallback"
	"rdrand"
	"rustc-dep-of-std"
	"std"
	"test-in-browser"
)
