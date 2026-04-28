# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror"
CRATE_VERSION="2.0.17"
CRATE_CHECKSUM="f63587ca0f12b72a0600bcba1d40081f830876000bb46dd2337a3051618f4fc8"
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
