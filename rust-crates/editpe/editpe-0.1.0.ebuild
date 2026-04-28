# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="editpe"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="48cede2bb1b07dd598d269f973792c43e0cd92686d3b452bd6e01d7a8eb01211"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Resource Editor for Portable Executables"
HOMEPAGE="https://github.com/Systemcluster/editpe"
LICENSE="BSD-2-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"image"
)
