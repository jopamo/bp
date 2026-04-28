# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_doc"
CRATE_VERSION="0.186.0"
CRATE_CHECKSUM="92de7919430e4bd66edace9ca4ca1dba7599ddf627bfa35a8c919b99ed5f54cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="doc generation for deno"
HOMEPAGE="https://github.com/denoland/deno_doc"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rust"
)
