# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_span"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="ca6f9fa2de07f5cccf431674b90e82c1fe1ea2339db3b3869eec44d135de09a4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="File and span related types for rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
)
