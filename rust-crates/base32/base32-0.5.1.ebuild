# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="base32"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="022dfe9eb35f19ebbcb51e0b40a5ab759f46ad60cadf7297e0bd085afb50e076"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Base32 encoder/decoder for Rust"
HOMEPAGE="https://github.com/andreasots/base32"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
