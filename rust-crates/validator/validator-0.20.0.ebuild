# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="validator"
CRATE_VERSION="0.20.0"
CRATE_CHECKSUM="43fb22e1a008ece370ce08a3e9e4447a910e92621bb49b85d6e48a45397e7cfa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common validation functions (email, url, length, ...) and trait - to be used with \`validator_derive\`"
HOMEPAGE="https://github.com/Keats/validator"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"card"
	"derive"
	"derive_nightly_features"
	"unic"
)
