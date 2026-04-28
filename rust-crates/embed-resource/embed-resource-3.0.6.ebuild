# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="embed-resource"
CRATE_VERSION="3.0.6"
CRATE_CHECKSUM="55a075fc573c64510038d7ee9abc7990635863992f83ebc52c8b433b8411a02e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Cargo library to handle compilation and inclusion of Windows resources in the most resilient fashion imaginable"
HOMEPAGE="https://github.com/nabijaczleweli/rust-embed-resource"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
