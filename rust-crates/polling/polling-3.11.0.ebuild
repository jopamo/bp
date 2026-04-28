# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="polling"
CRATE_VERSION="3.11.0"
CRATE_CHECKSUM="5d0e4f59085d47d8241c88ead0f274e8a0cb551f3625263c05eb8dd897c34218"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable interface to epoll, kqueue, event ports, and IOCP"
HOMEPAGE="https://github.com/smol-rs/polling"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
