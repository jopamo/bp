# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="malloc_buf"
CRATE_VERSION="0.0.6"
CRATE_CHECKSUM="62bb907fe88d54d8d9ce32a3cceab4218ed2f6b7d35617cafe9adf84e43919cb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Structs for handling malloc'd memory passed to Rust."
HOMEPAGE="https://github.com/SSheldon/malloc_buf"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
