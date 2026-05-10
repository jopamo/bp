# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode_names2_generator"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="b91e5b84611016120197efd7dc93ef76774f4e084cd73c9fb3ea4a86c570c56e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generates the perfect-hash function used by \`unicode_names2\`."
HOMEPAGE="https://github.com/progval/unicode_names2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"timing"
	"unstable"
)
