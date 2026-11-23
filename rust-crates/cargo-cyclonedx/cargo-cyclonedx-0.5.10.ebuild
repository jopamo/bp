# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cargo-cyclonedx"
CRATE_VERSION="0.5.10"
CRATE_CHECKSUM="705522d9b1837be5dfdd3829791140a85cbba18f64b9af577c932bbbe5dbdba7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CycloneDX Software Bill of Materials (SBOM) for Rust Crates"
HOMEPAGE="https://cyclonedx.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
