# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_lexer"
CRATE_VERSION="23.0.2"
CRATE_CHECKSUM="017d06ea85008234aa9fb34d805c7dc563f2ea6e03869ed5ac5a2dc27d561e4d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Feature-complete es2019 parser."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"tracing-spans"
	"typescript"
	"verify"
)
