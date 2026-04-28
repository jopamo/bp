# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-async-runtimes"
CRATE_VERSION="0.26.0"
CRATE_CHECKSUM="e6ee6d4cb3e8d5b925f5cdb38da183e0ff18122eb2048d4041c9e7034d026e23"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PyO3 bridges from Rust runtimes to Python's Asyncio library"
HOMEPAGE="https://github.com/PyO3/pyo3-async-runtimes"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-std-runtime"
	"attributes"
	"default"
	"testing"
	"tokio-runtime"
	"unstable-streams"
)
