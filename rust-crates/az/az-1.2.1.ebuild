# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="az"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="7b7e4c2464d97fe331d41de9d5db0def0a96f4d823b8b32a2efd503578988973"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Casts and checked casts"
HOMEPAGE="https://gitlab.com/tspiteri/az"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"fail-on-warnings"
)
