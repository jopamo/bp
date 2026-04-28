# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-cyclonedx"
CRATE_VERSION="0.5.9"
CRATE_CHECKSUM="5d162f67705f0f5038759d73bf546a083bf30e8677c2e944b416bca48d9d69a8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="CycloneDX Software Bill of Materials (SBOM) for Rust Crates"
HOMEPAGE="https://cyclonedx.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
