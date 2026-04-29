# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="const-str"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="18f12cc9948ed9604230cdddc7c86e270f9401ccbe3c2e98a4378c5e7632212f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="compile-time string operations"
HOMEPAGE="https://github.com/Nugine/const-str"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"all"
	"case"
	"default"
	"http"
	"proc"
	"regex"
	"std"
	"unstable"
)
