# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="utf8parse"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af800a370a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Table-driven UTF-8 parser"
HOMEPAGE="https://github.com/alacritty/vte"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
)
