# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_base_db"
CRATE_VERSION="0.0.358"
CRATE_CHECKSUM="8a5bf74ba5606b902ada6b8964ac4f22080ac6d73c297f8d4981885843b25fa4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Basic database trait and infra for rust-analyzer's crate and source root inputs. The concrete DB is defined by \`ide\` (aka \`ra_ap_ide\`)."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"in-rust-tree"
)
