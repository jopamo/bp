# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc_version"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for querying the version of a installed rustc compiler"
HOMEPAGE="https://github.com/djc/rustc-version-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
