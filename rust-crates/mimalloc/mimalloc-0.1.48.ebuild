# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mimalloc"
CRATE_VERSION="0.1.48"
CRATE_CHECKSUM="e1ee66a4b64c74f4ef288bcbb9192ad9c3feaad75193129ac8509af543894fd8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Performance and security oriented drop-in allocator"
HOMEPAGE="https://github.com/purpleprotocol/mimalloc_rust"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"debug_in_debug"
	"default"
	"extended"
	"local_dynamic_tls"
	"no_thp"
	"override"
	"secure"
	"v3"
)
