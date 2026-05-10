# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="asn1-rs-impl"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="7b18050c2cd6fe86c3a76584ef5e0baf286d038cda203eb6223df2cc413565f7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation details for the \`asn1-rs\` crate"
HOMEPAGE="https://github.com/rusticata/asn1-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
