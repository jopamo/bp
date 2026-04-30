# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="quoted_printable"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="478e0585659a122aa407eb7e3c0e1fa51b1d8a870038bd29f0cf4a8551eea972"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple encoder/decoder for quoted-printable data"
HOMEPAGE="https://github.com/staktrace/quoted-printable/blob/master/README.md"
LICENSE="0BSD"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
