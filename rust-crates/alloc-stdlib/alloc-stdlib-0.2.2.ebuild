# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="alloc-stdlib"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A dynamic allocator example that may be used with the stdlib"
HOMEPAGE="https://github.com/dropbox/rust-alloc-no-stdlib"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"unsafe"
)
