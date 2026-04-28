# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="alloc-no-stdlib"
CRATE_VERSION="2.0.4"
CRATE_CHECKSUM="cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A dynamic allocator that may be used with or without the stdlib. This allows a package with nostd to allocate memory dynamically and be used either with a custom allocator, items on the stack, or by a package that wishes to simply use Box<>. It also provides options to use calloc or a mutable global variable for pre-zeroed memory"
HOMEPAGE="https://github.com/dropbox/rust-alloc-no-stdlib"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"unsafe"
)
