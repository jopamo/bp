# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_npm"
CRATE_VERSION="0.42.0"
CRATE_CHECKSUM="ae246f5c39baf58dfbb8250068ec35223f4c4c19889bfad732d92a035bf74fe6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="npm registry client and dependency resolver used in the Deno CLI"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"tracing"
)
