# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="schemars_derive"
CRATE_VERSION="1.0.4"
CRATE_CHECKSUM="33d020396d1d138dc19f1165df7545479dcd58d93810dc5d646a16e55abefa80"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros for #[derive(JsonSchema)], for use with schemars"
HOMEPAGE="https://graham.cool/schemars/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
