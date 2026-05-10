# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ambient-id"
CRATE_VERSION="0.0.5"
CRATE_CHECKSUM="a55e62faa820045efacb144fd9bcb16e62a5960ffc4bc270aaff7b78f0fcdcaa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Detects ambient OIDC credentials in a variety of environments"
HOMEPAGE="https://github.com/astral-sh/ambient-id"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"test-github-1p"
)
