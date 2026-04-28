# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc_version"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for querying the version of a installed rustc compiler"
HOMEPAGE="https://github.com/Kimundi/rustc-version-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
