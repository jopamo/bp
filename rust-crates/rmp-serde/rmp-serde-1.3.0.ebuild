# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rmp-serde"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="52e599a477cf9840e92f2cde9a7189e67b42c57532749bf90aea6ec10facd4db"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde bindings for RMP"
HOMEPAGE="https://github.com/3Hren/msgpack-rust"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
