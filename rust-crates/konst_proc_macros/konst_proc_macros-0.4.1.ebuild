# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="konst_proc_macros"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="e037a2e1d8d5fdbd49b16a4ea09d5d6401c1f29eca5ff29d03d3824dba16256a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the \`konst\` crate"
HOMEPAGE="https://github.com/rodrimati1992/konst/"
LICENSE="Zlib"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
