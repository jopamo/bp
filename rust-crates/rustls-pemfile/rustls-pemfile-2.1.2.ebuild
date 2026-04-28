# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-pemfile"
CRATE_VERSION="2.1.2"
CRATE_CHECKSUM="29993a25686778eb88d4189742cd713c9bce943bc54251a33509dc63cbacf73d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Basic .pem file parser for keys and certificates"
HOMEPAGE="https://github.com/rustls/pemfile"
LICENSE="|| ( Apache-2.0 ISC MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
