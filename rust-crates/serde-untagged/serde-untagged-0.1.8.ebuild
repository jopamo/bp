# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde-untagged"
CRATE_VERSION="0.1.8"
CRATE_CHECKSUM="34836a629bcbc6f1afdf0907a744870039b1e14c0561cb26094fa683b158eff3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde \`Visitor\` implementation for deserializing untagged enums"
HOMEPAGE="https://github.com/dtolnay/serde-untagged"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
