# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="jsonwebtoken"
CRATE_VERSION="9.3.1"
CRATE_CHECKSUM="5a87cc7a48537badeae96744432de36f4be2b4a34a05a5ef32e9dd8a1c169dde"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Create and decode JWTs in a strongly typed way."
HOMEPAGE="https://github.com/Keats/jsonwebtoken"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_pem"
)
