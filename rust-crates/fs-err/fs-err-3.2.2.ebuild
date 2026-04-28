# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fs-err"
CRATE_VERSION="3.2.2"
CRATE_CHECKSUM="baf68cef89750956493a66a10f512b9e58d9db21f2a573c079c0bdf1207a54a7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A drop-in replacement for std::fs with more helpful error messages."
HOMEPAGE="https://github.com/andrewhickman/fs-err"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"debug_tokio"
	"expose_original_error"
)
