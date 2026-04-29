# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jiter"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="b6f3b5d3f84b36f4ad09fd1da896d23d9852a1aa86556578dd0289f43dce311d"
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
