# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libmimalloc-sys"
CRATE_VERSION="0.1.44"
CRATE_CHECKSUM="667f4fec20f29dfc6bc7357c582d91796c169ad7e2fce709468aefeb2c099870"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Sys crate wrapping the mimalloc allocator"
HOMEPAGE="https://github.com/purpleprotocol/mimalloc_rust/tree/master/libmimalloc-sys"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arena"
	"debug"
	"debug_in_debug"
	"extended"
	"local_dynamic_tls"
	"no_thp"
	"override"
	"secure"
	"v3"
)
