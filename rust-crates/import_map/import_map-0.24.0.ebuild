# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="import_map"
CRATE_VERSION="0.24.0"
CRATE_CHECKSUM="f83a4958a41489355816028239fee373797435384d162f4908e7980c83c3bb1b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of WICG Import Maps specification"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"ext"
	"logging"
)
