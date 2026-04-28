# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="version_check"
CRATE_VERSION="0.9.4"
CRATE_CHECKSUM="49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tiny crate to check the version of the installed/running rustc."
HOMEPAGE="https://github.com/SergioBenitez/version_check"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
