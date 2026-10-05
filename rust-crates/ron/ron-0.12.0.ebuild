# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ron"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="fd490c5b18261893f14449cbd28cb9c0b637aebf161cd77900bfdedaff21ec32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rusty Object Notation"
HOMEPAGE="https://github.com/ron-rs/ron"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"indexmap"
	"integer128"
	"internal-span-substring-test"
	"std"
)
