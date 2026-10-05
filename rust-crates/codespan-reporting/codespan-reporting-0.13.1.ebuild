# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="codespan-reporting"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="af491d569909a7e4dee0ad7db7f5341fef5c614d5b8ec8cf765732aba3cff681"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Beautiful diagnostic reporting for text-based programming languages"
HOMEPAGE="https://github.com/brendanzab/codespan"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ascii-only"
	"default"
	"serialization"
	"std"
	"termcolor"
)
