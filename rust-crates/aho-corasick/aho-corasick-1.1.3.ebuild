# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aho-corasick"
CRATE_VERSION="1.1.3"
CRATE_CHECKSUM="8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
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
