# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="eszip"
CRATE_VERSION="0.104.0"
CRATE_CHECKSUM="dde1007099ac5d0184579513aa0d5484ad25d9638a21c7c26203548aebe40d9b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A utility that can download JavaScript and TypeScript module graphs and store them locally in a special zip file"
HOMEPAGE="https://github.com/denoland/eszip"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"sha256"
	"xxhash3"
)
