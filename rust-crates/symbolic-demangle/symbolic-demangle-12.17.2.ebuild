# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="symbolic-demangle"
CRATE_VERSION="12.17.2"
CRATE_CHECKSUM="79b237cfbe320601dd24b4ac817a5b68bb28f5508e33f08d42be0682cadc8ac9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to demangle symbols from various languages and compilers."
HOMEPAGE="https://github.com/getsentry/symbolic"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cpp"
	"default"
	"msvc"
	"rust"
	"swift"
)
