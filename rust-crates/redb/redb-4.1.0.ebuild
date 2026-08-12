# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="redb"
CRATE_VERSION="4.1.0"
CRATE_CHECKSUM="8e925444704b5f17d32bf42f5b6e2df050bceebc3dcd6e71cc73dafe8092e839"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust Embedded DataBase"
HOMEPAGE="https://www.redb.org"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cache_metrics"
	"logging"
)
