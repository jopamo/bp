# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="asn1-rs-impl"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation details for the `asn1-rs` crate"
HOMEPAGE="https://github.com/rusticata/asn1-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
