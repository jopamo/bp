# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indoc"
CRATE_VERSION="2.0.7"
CRATE_CHECKSUM="79cf5c93f93228cf8efb3ba362535fb11199ac548a09ce117c9b1adc3030d706"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Indented document literals"
HOMEPAGE="https://github.com/dtolnay/indoc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
