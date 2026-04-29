# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiter"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="8e805fb15a8249d25213202b9098f7b9ad00f8042ccc6f0063d2ae7b33f3d7da"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast Iterable JSON parser"
HOMEPAGE="https://github.com/pydantic/jiter/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"num-bigint"
	"python"
)
