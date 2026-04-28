# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lsp-types"
CRATE_VERSION="0.97.0"
CRATE_CHECKSUM="53353550a17c04ac46c585feb189c2db82154fc84b79c7a66c96c2c644f66071"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types for interaction with a language server, using VSCode's Language Server Protocol"
HOMEPAGE="https://github.com/gluon-lang/lsp-types"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proposed"
)
