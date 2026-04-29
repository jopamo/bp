# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="indoc"
CRATE_VERSION="2.0.6"
CRATE_CHECKSUM="f4c7245a08504955605670dbf141fceab975f15ca21570696aebe9d2e71576bd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Indented document literals"
HOMEPAGE="https://github.com/dtolnay/indoc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
