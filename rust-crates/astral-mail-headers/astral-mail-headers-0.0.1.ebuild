# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="astral-mail-headers"
CRATE_VERSION="0.0.1"
CRATE_CHECKSUM="dc019ecca82cfc91ffa31ab4ffe705aaa706399840a7152926b7eee736da410a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A high-performance email header parser designed for Python packaging"
HOMEPAGE="https://github.com/astral-sh/astral-mail-headers"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"benchmark-jemalloc"
)
