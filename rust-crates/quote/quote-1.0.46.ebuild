# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quote"
CRATE_VERSION="1.0.46"
CRATE_CHECKSUM="dfbc457d0c7a0759a614551b11a6409e5951f6c7537be1f1b7682b9ae9230368"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quasi-quoting macro quote!(...)"
HOMEPAGE="https://github.com/dtolnay/quote"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
