# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-id"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="10103c57044730945224467c09f71a4db0071c123a0648cc3e818913bde6b561"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Determine whether characters have the ID_Start or ID_Continue properties according to Unicode Standard Annex #31."
HOMEPAGE="https://github.com/Boshen/unicode-id"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bench"
	"default"
	"no_std"
)
