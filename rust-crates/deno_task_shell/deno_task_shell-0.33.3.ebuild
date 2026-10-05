# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_task_shell"
CRATE_VERSION="0.33.3"
CRATE_CHECKSUM="8ac466d733d16a8ab5268b7e83a407289b25060a8f96dadc5cb96232a67c5282"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross platform scripting for deno task"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serialization"
	"shell"
)
