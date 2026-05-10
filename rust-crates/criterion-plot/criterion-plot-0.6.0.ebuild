# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="criterion-plot"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="9b1bcc0dc7dfae599d84ad0b1a55f80cde8af3725da8313b528da95ef783e338"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Criterion's plotting library"
HOMEPAGE="https://github.com/bheisler/criterion.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
