# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-async-runtimes"
CRATE_VERSION="0.25.0"
CRATE_CHECKSUM="d73cc6b1b7d8b3cef02101d37390dbdfe7e450dfea14921cae80a9534ba59ef2"
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
