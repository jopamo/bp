# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libnghttp2"
CRATE_VERSION="1.68.0"
CRATE_CHECKSUM="de061ac7dc8893bbb8b212a03444dc19f0f2f28e2be4c80dbc19aa9cc45586e5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings to the HTTP/2 framing layer of nghttp2 C library"
HOMEPAGE="https://github.com/littledivy/libnghttp2"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
