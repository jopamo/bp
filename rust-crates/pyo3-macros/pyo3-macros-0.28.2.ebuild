# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-macros"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="f5d671734e9d7a43449f8480f8b38115df67bef8d21f76837fa75ee7aaa5e52e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macros for PyO3 package"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental-async"
	"experimental-inspect"
	"multiple-pymethods"
)
