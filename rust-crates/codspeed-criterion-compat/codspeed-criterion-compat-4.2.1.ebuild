# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codspeed-criterion-compat"
CRATE_VERSION="4.2.1"
CRATE_CHECKSUM="d16fe2db207123f7b3a3b5cfff0c22f99469f7534145f3573f57f4c8a5653c2c"
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
