# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_yaml"
CRATE_VERSION="0.9.34+deprecated"
CRATE_CHECKSUM="6a8b1a1a2ebf674015cc02edccce75287f1a0130d394307b36743c2f5d504b47"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="YAML data format for Serde"
HOMEPAGE="https://github.com/dtolnay/serde-yaml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
