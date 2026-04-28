# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc_version"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="bfa0f585226d2e68097d4f95d113b15b83a82e819ab25717ec0590d9584ef366"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for querying the version of a installed rustc compiler"
HOMEPAGE="https://github.com/Kimundi/rustc-version-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
