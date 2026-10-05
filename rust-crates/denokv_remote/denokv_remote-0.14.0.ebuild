# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="denokv_remote"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="8ce7f058cc5e0bcd230b07451bf7ee46b1b30c4d37f895cb736e43ce6a23dbf7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Remote (KV Connect) backend for Deno KV"
HOMEPAGE="https://github.com/denoland/denokv"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
