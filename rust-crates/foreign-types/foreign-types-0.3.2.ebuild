# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foreign-types"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A framework for Rust wrappers over C APIs"
HOMEPAGE="https://github.com/sfackler/foreign-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
