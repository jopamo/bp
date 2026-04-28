# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tempfile"
CRATE_VERSION="3.10.1"
CRATE_CHECKSUM="85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for managing temporary files and directories."
HOMEPAGE="https://stebalien.com/projects/tempfile-rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
