# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="kqueue"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="eac30106d7dce88daf4a3fcb4879ea939476d5074a9b7ddd0fb97fa4bed5596a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="kqueue interface for BSDs"
HOMEPAGE="https://gitlab.com/rust-kqueue/rust-kqueue"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
