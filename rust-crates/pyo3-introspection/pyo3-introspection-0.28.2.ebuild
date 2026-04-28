# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pyo3-introspection"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="cc11f40a1f5ec62a36963d4b4b0c051fac90c879c640baa975f45cd01afd3c38"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Introspect dynamic libraries built with PyO3 to get metadata about the exported Python types"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
