# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="git-version-macro"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="53010ccb100b96a67bc32c0175f0ed1426b31b655d562898e57325f81c023ac0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Internal macro crate for git-version."
HOMEPAGE="https://github.com/fusion-engineering/rust-git-version"
LICENSE="BSD-2-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
