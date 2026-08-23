# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="argfile"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="99489a733dea0d2930bfa59c243146a8513ce7b0991b9d006647687cc61f53e7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Load additional CLI args from file"
HOMEPAGE="https://github.com/rust-cli/argfile"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"response"
)
