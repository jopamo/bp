# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_parser"
CRATE_VERSION="24.0.3"
CRATE_CHECKSUM="2e9011783c975ba592ffc09cd208ced92b1dfabb2e5e0ef453559e2e25286127"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Feature-complete es2019 parser."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"tracing-spans"
	"typescript"
	"unstable"
	"verify"
)
