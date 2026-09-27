# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_base_db"
CRATE_VERSION="0.0.347"
CRATE_CHECKSUM="7ea804efdf7c1fdbdac7c1b08002700a6f2930590399abcf84d55b4d4a894116"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Basic database traits for rust-analyzer. The concrete DB is defined by \`ide\` (aka \`ra_ap_ide\`)."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"in-rust-tree"
)
