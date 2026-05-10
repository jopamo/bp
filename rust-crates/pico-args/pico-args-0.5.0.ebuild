# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pico-args"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="5be167a7af36ee22fe3115051bc51f6e6c7054c9348e28deb4f49bd6f705a315"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An ultra simple CLI arguments parser."
HOMEPAGE="https://github.com/RazrFalcon/pico-args"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"combined-flags"
	"default"
	"eq-separator"
	"short-space-opt"
)
