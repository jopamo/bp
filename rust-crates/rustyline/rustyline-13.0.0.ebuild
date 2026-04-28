# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustyline"
CRATE_VERSION="13.0.0"
CRATE_CHECKSUM="02a2d683a4ac90aeef5b1013933f6d977bd37d51ff3f4dad829d4931a7e6be86"
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
