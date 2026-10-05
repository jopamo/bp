# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libuv-sys-lite"
CRATE_VERSION="1.48.4"
CRATE_CHECKSUM="ef43df715b26b66832106cde0adc4c156bc91f46fc35164ab257281f62657956"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tiny, raw bindings to libuv without linking to it"
HOMEPAGE="https://github.com/nathanwhit/libuv-sys-lite"
LICENSE="non-standard"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bindgen"
	"default"
	"dyn-symbols"
	"warn-missing"
)
