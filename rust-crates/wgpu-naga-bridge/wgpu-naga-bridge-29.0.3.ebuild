# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-naga-bridge"
CRATE_VERSION="29.0.3"
CRATE_CHECKSUM="59c654c483f058800972c3645e95388a7eca31bf9fe1933bc20e036588a0be02"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Conversions between naga and wgpu-types. Part of the wgpu project"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
