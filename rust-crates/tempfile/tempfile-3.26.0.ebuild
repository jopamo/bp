# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tempfile"
CRATE_VERSION="3.26.0"
CRATE_CHECKSUM="82a72c767771b47409d2345987fda8628641887d5466101319899796367354a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for managing temporary files and directories."
HOMEPAGE="https://stebalien.com/projects/tempfile-rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
)
