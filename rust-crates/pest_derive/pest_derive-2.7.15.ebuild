# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pest_derive"
CRATE_VERSION="2.7.15"
CRATE_CHECKSUM="816518421cfc6887a0d62bf441b6ffb4536fcc926395a69e1a85852d4363f57e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pest's derive macro"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"grammar-extras"
	"not-bootstrap-in-src"
	"std"
)
