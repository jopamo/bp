# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anyhow"
CRATE_VERSION="1.0.98"
CRATE_CHECKSUM="e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Flexible concrete Error type built on std::error::Error"
HOMEPAGE="https://github.com/dtolnay/anyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
