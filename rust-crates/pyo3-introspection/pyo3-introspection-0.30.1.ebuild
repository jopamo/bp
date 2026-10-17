# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pyo3-introspection"
CRATE_VERSION="0.30.1"
CRATE_CHECKSUM="3b2ac30f128e6ab4ca1c464d6eabd30c84c7adc5955c3bb2eb7d203ea24ebd18"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Introspect dynamic libraries built with PyO3 to get metadata about the exported Python types"
HOMEPAGE="https://pyo3.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
