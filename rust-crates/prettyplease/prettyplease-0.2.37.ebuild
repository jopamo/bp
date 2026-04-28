# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prettyplease"
CRATE_VERSION="0.2.37"
CRATE_CHECKSUM="479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b"
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
