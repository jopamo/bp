# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="vcpkg"
CRATE_VERSION="0.2.15"
CRATE_CHECKSUM="accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to find native dependencies in a vcpkg tree at build time in order to be used in Cargo build scripts."
HOMEPAGE="https://github.com/mcgoo/vcpkg-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
