# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pest_meta"
CRATE_VERSION="2.7.15"
CRATE_CHECKSUM="e1e58089ea25d717bfd31fb534e4f3afcc2cc569c70de3e239778991ea3b7dea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pest meta language parser and validator"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"grammar-extras"
	"not-bootstrap-in-src"
)
