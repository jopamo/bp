# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lol_html"
CRATE_VERSION="2.6.0"
CRATE_CHECKSUM="b63d49c99bfbf3400dd6450e516515b7014fcb49b5cb533f4b725a00c1462a36"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Streaming HTML rewriter/parser with CSS selector-based API"
HOMEPAGE="https://github.com/cloudflare/lol-html"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug_trace"
	"integration_test"
)
