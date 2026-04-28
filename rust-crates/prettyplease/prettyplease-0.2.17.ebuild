# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prettyplease"
CRATE_VERSION="0.2.17"
CRATE_CHECKSUM="8d3928fb5db768cb86f891ff014f0144589297e3c6a1aba6ed7cecfdace270c7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A minimal \`syn\` syntax tree pretty-printer"
HOMEPAGE="https://github.com/dtolnay/prettyplease"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"verbatim"
)
