# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="asn1-rs-derive"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="3109e49b1e4909e9db6515a30c633684d68cdeaa252f215214cb4fa1a5bfee2c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macros for the \`asn1-rs\` crate"
HOMEPAGE="https://github.com/rusticata/asn1-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
