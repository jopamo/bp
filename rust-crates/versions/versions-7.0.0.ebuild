# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="versions"
CRATE_VERSION="7.0.0"
CRATE_CHECKSUM="80a7e511ce1795821207a837b7b1c8d8aca0c648810966ad200446ae58f6667f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for parsing and comparing software version numbers."
HOMEPAGE="https://github.com/fosskers/rs-versions"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
