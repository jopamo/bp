# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-lock"
CRATE_VERSION="11.1.0"
CRATE_CHECKSUM="50524592e6bfbb1bf6f94e8184a786f637faeaf1cf37bbe65502b9a2c5c48939"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Self-contained Cargo.lock parser with optional dependency graph analysis"
HOMEPAGE="https://rustsec.org"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cli"
	"dependency-tree"
)
