# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-introspection"
CRATE_VERSION="0.28.3"
CRATE_CHECKSUM="96040524552ac54e645ce08146b24023d720ceb0e788fff758c0beb9fe841736"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Introspect dynamic libraries built with PyO3 to get metadata about the exported Python types"
HOMEPAGE="https://github.com/pyo3/pyo3"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
