# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="comrak"
CRATE_VERSION="0.29.0"
CRATE_CHECKSUM="d8c32ff8b21372fab0e9ecc4e42536055702dc5faa418362bffd1544f9d12637"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A 100% CommonMark-compatible GitHub Flavored Markdown parser and formatter"
HOMEPAGE="https://github.com/kivikakk/comrak"
LICENSE="BSD-2-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"cli"
	"default"
	"shortcodes"
)
