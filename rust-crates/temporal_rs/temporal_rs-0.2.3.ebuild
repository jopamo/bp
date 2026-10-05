# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="temporal_rs"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="9a902a45282e5175186b21d355efc92564601efe6e2d92818dc9e333d50bd4de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Temporal in Rust is an implementation of the TC39 Temporal Builtin Proposal in Rust."
HOMEPAGE="https://github.com/boa-dev/temporal"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"compiled_data"
	"default"
	"float64_representable_durations"
	"log"
	"std"
	"sys"
	"sys-local"
	"tzdb"
)
