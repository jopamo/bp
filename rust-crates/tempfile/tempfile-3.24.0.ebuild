# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tempfile"
CRATE_VERSION="3.24.0"
CRATE_CHECKSUM="655da9c7eb6305c55742045d5a8d2037996d61d8de95806335c7c86ce0f82e9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for managing temporary files and directories."
HOMEPAGE="https://stebalien.com/projects/tempfile-rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
)
