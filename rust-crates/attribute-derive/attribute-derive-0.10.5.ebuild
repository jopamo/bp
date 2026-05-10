# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="attribute-derive"
CRATE_VERSION="0.10.5"
CRATE_CHECKSUM="05832cdddc8f2650cc2cc187cc2e952b8c133a48eb055f35211f61ee81502d77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Clap like parsing for attributes in proc-macros"
HOMEPAGE="https://github.com/ModProg/attribute-derive"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"syn-full"
)
