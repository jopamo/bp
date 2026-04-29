# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="predicates-core"
CRATE_VERSION="1.0.10"
CRATE_CHECKSUM="cad38746f3166b4031b1a0d39ad9f954dd291e7854fcc0eed52ee41a0b50d144"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An API for boolean-valued predicate functions."
HOMEPAGE="https://github.com/assert-rs/predicates-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
