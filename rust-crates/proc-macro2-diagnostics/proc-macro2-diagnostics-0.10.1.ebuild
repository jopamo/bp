# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro2-diagnostics"
CRATE_VERSION="0.10.1"
CRATE_CHECKSUM="af066a9c399a26e020ada66a034357a868728e72cd426f3adcd35f80d88d88c8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Diagnostics for proc-macro2."
HOMEPAGE="https://github.com/SergioBenitez/proc-macro2-diagnostics"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"colors"
	"default"
)
