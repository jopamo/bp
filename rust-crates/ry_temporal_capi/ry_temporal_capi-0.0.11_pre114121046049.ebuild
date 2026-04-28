# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ry_temporal_capi"
CRATE_VERSION="0.0.11-ry.1"
CRATE_CHECKSUM="cdfddefd45ee4814bd83d94b7196c95ef6af159f4a0035a6c67bd59edcff14ee"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="C interface to temporal_rs"
HOMEPAGE="https://github.com/boa-dev/temporal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
)
