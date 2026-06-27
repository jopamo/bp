# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="insta"
CRATE_VERSION="1.48.0"
CRATE_CHECKSUM="86f0f8fee8c926415c58d6ae43a08523a26faccb2323f5e6b644fe7dd4ef6b82"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A snapshot testing library for Rust"
HOMEPAGE="https://insta.rs/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_cargo_insta_internal"
	"colors"
	"csv"
	"default"
	"filters"
	"glob"
	"json"
	"redactions"
	"ron"
	"toml"
	"yaml"
)
