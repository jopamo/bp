# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xdg"
CRATE_VERSION="3.0.0"
CRATE_CHECKSUM="2fb433233f2df9344722454bc7e96465c9d03bff9d77c248f9e7523fe79585b5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for storing and retrieving files according to XDG Base Directory specification"
HOMEPAGE="https://github.com/whitequark/rust-xdg"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
