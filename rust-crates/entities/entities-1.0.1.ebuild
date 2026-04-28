# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="entities"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="b5320ae4c3782150d900b79807611a59a99fc9a1d61d686faafc24b93fc8d7ca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides the raw data needed to convert to and from HTML entities."
HOMEPAGE="https://github.com/p-jackson/entities"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
