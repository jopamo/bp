# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="denokv_sqlite"
CRATE_VERSION="0.12.0"
CRATE_CHECKSUM="f119506add29e620d1a6d37903d727a6abab0feb0f2e898554b0a10d1113ab32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SQLite storage backend for Deno KV"
HOMEPAGE="https://github.com/denoland/denokv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
