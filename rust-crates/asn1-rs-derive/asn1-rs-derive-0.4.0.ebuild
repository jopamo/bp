# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="asn1-rs-derive"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macros for the \`asn1-rs\` crate"
HOMEPAGE="https://github.com/rusticata/asn1-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
