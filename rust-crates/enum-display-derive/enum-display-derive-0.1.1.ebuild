# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="enum-display-derive"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="f16ef37b2a9b242295d61a154ee91ae884afff6b8b933b486b12481cc58310ca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Display trait's custom derive for simple enums."
HOMEPAGE="https://github.com/ihrwein/enum-display-derive"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
