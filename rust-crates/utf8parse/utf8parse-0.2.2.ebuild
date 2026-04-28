# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="utf8parse"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
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
