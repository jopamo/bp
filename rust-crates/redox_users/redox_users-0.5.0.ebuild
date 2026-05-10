# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="redox_users"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="dd6f9d3d47bdd2ad6945c5015a226ec6155d0bcdfd8f7cd29f86b71f8de99d2b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust library to access Redox users and groups functionality"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/users"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"auth"
	"default"
)
