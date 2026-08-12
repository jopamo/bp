# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="aho-corasick"
CRATE_VERSION="1.1.5"
CRATE_CHECKSUM="c982642fa9e8606056828ee9a8505737230110bb1099153c79efe865c59d12ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast multiple substring searching."
HOMEPAGE="https://github.com/BurntSushi/aho-corasick"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"logging"
	"perf-literal"
	"std"
)
