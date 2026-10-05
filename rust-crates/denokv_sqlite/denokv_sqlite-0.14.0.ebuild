# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="denokv_sqlite"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="9cedc50f9f299c8e3b33c81156a34b24a82a85e2b22cd9100db6b9c45f5c8c31"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SQLite storage backend for Deno KV"
HOMEPAGE="https://github.com/denoland/denokv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
