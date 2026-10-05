# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="import_map"
CRATE_VERSION="0.25.0"
CRATE_CHECKSUM="61dcb2ebdf4a4df8e6353c566f4b51ee2f602341538e41e77c8f861ac1bb16d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of WICG Import Maps specification"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"ext"
	"logging"
)
