# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lru"
CRATE_VERSION="0.16.3"
CRATE_CHECKSUM="a1dc47f592c06f33f8e3aea9591776ec7c9f9e4124778ff8a3c3b87159f7e593"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A LRU cache implementation"
HOMEPAGE="https://github.com/jeromefroe/lru-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
)
