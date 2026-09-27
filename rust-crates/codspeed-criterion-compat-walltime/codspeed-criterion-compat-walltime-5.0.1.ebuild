# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codspeed-criterion-compat-walltime"
CRATE_VERSION="5.0.1"
CRATE_CHECKSUM="5c38205d56e2cb4fe04b708de7f9653a3f1b89edbe3a20b28f21e9e525e9e061"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Statistics-driven micro-benchmarking library"
HOMEPAGE="https://codspeed.io"
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
	"real_blackbox"
	"stable"
)
