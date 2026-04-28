# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="codespan-reporting"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="3538270d33cc669650c4b093848450d380def10c331d38c768e34cac80576e6e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Beautiful diagnostic reporting for text-based programming languages"
HOMEPAGE="https://github.com/brendanzab/codespan"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ascii-only"
	"serialization"
)
