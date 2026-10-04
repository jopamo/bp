# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ra_ap_base_db"
CRATE_VERSION="0.0.352"
CRATE_CHECKSUM="4ce5c7b9d3f79c6275948b067cddc352b56c7e3f33fc204a66520b7c7fe7d9ca"
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
