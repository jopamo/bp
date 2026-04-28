# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vte_generate_state_changes"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="d257817081c7dffcdbab24b9e62d2def62e2ff7d00b1c20062551e6cccc145ff"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macro for generating VTE state changes"
HOMEPAGE="https://github.com/jwilm/vte"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
