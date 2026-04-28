# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="write16"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="d1890f4022759daae28ed4fe62859b1236caebfc61ede2f63ed4e695f3f6d936"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A UTF-16 analog of the Write trait"
HOMEPAGE="https://docs.rs/write16/"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
)
