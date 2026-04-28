# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hdrhistogram"
CRATE_VERSION="7.5.4"
CRATE_CHECKSUM="765c9198f173dd59ce26ff9f95ef0aafd0a0fe01fb9d72841bc5066a4c06511d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A port of HdrHistogram to Rust"
HOMEPAGE="https://github.com/HdrHistogram/HdrHistogram_rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"bench_private"
	"default"
	"serialization"
	"sync"
)
