# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="axoprocess"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="8a4b4798a6c02e91378537c63cd6e91726900b595450daa5d487bc3c11e95e1b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Nicer defaults for invoking CLI Commands"
HOMEPAGE="https://github.com/axodotdev/axoprocess"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"stdout_to_stderr_modern"
)
