# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="criterion"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="e1c047a62b0cc3e145fa84415a3191f628e980b194c2755aa12300a4e6cbd928"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Statistics-driven micro-benchmarking library"
HOMEPAGE="https://bheisler.github.io/criterion.rs/book/index.html"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async"
	"async_futures"
	"async_smol"
	"async_std"
	"async_tokio"
	"cargo_bench_support"
	"csv_output"
	"default"
	"html_reports"
	"plotters"
	"rayon"
	"real_blackbox"
	"stable"
)
