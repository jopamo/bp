# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ruff_python_ast"
CRATE_VERSION="0.0.0"
CRATE_CHECKSUM="248dece1157347eade855b663ef0eef4b1797e29779c2cce7fc769f51c05c298"
CRATE_SOURCE="git+https://github.com/astral-sh/ruff?tag=0.15.5#5e4a3d9c3b381df20f6a52caef0f56ed0ebc74be"
CRATE_SOURCE_KIND="git"

inherit cargo-crate

DESCRIPTION="Lockstep-managed cargo crate ruff_python_ast"
HOMEPAGE="https://docs.astral.sh/ruff"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cache"
	"get-size"
	"schemars"
	"serde"
)
