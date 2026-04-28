# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pear_codegen"
CRATE_VERSION="0.2.9"
CRATE_CHECKSUM="4bab5b985dc082b345f812b7df84e1bef27e7207b39e448439ba8bd69c93f147"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A (codegen) pear is a fruit."
HOMEPAGE="https://github.com/SergioBenitez/Pear"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
