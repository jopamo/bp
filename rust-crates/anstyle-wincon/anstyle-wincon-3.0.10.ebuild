# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-wincon"
CRATE_VERSION="3.0.10"
CRATE_CHECKSUM="3e0633414522a32ffaac8ac6cc8f748e090c5717661fddeea04219e2344f5f2a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Styling legacy Windows terminals"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
