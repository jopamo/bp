# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="csv-core"
CRATE_VERSION="0.1.12"
CRATE_CHECKSUM="7d02f3b0da4c6504f86e9cd789d8dbafab48c2321be74e9987593de5a894d93d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bare bones CSV parsing with no_std support."
HOMEPAGE="https://github.com/BurntSushi/rust-csv"
LICENSE="|| ( Unlicense MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"libc"
)
