# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-platform"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="87a0c0e6148f11f01f32650a2ea02d532b2ad4e81d8bd41e6e565b5adc5e6082"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cargo's representation of a target platform."
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
