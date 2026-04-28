# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="stringcase"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="72abeda133c49d7bddece6c154728f83eec8172380c80ab7096da9487e20d27c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Converts string cases between camelCase, COBOL-CASE, kebab-case, and so on."
HOMEPAGE="https://github.com/sttk/stringcase-rust"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
