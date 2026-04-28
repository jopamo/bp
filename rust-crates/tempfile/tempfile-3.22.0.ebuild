# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tempfile"
CRATE_VERSION="3.22.0"
CRATE_CHECKSUM="84fa4d11fadde498443cca10fd3ac23c951f0dc59e080e9f4b93d4df4e4eea53"
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
