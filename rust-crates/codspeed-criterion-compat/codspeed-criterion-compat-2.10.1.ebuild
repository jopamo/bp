# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="codspeed-criterion-compat"
CRATE_VERSION="2.10.1"
CRATE_CHECKSUM="c3c23d880a28a2aab52d38ca8481dd7a3187157d0a952196b6db1db3c8499725"
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
