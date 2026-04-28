# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="iana-time-zone"
CRATE_VERSION="0.1.63"
CRATE_CHECKSUM="b0c919e5debc312ad217002b8048a17b7d83f80703865bbfcfebb0458b0b27d8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="get the IANA time zone for the current system"
HOMEPAGE="https://github.com/strawlab/iana-time-zone"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"fallback"
)
