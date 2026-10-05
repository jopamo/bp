# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustyline"
CRATE_VERSION="17.0.0"
CRATE_CHECKSUM="ed34fbd08950d17f8297e738d5b76acd4baab50c8d45008d498b4327feb43ea1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustyline, a readline implementation based on Antirez's Linenoise"
HOMEPAGE="https://github.com/kkawakam/rustyline"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"case_insensitive_history_search"
	"custom-bindings"
	"default"
	"derive"
	"with-dirs"
	"with-file-history"
	"with-fuzzy"
	"with-sqlite-history"
)
