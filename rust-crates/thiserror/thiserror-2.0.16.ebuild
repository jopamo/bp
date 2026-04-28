# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror"
CRATE_VERSION="2.0.16"
CRATE_CHECKSUM="3467d614147380f2e4e374161426ff399c91084acd2363eaf549172b3d5e60c0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="derive(Error)"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
