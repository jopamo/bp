# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codspeed-criterion-compat"
CRATE_VERSION="5.0.1"
CRATE_CHECKSUM="d9f24251445188c69d50f10179d795424bd71b533b7e3f84fc03f26893b01af0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Criterion.rs compatibility layer for CodSpeed"
HOMEPAGE="https://codspeed.io"
LICENSE="|| ( MIT Apache-2.0 )"
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
)
