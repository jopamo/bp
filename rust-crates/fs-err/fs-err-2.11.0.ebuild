# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fs-err"
CRATE_VERSION="2.11.0"
CRATE_CHECKSUM="88a41f105fe1d5b6b34b2055e3dc59bb79b46b48b2040b9e6c7b4b5de097aa41"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A drop-in replacement for std::fs with more helpful error messages."
HOMEPAGE="https://github.com/andrewhickman/fs-err"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"io_safety"
)
