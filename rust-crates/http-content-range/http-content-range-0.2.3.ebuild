# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="http-content-range"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="63f67baaf67a9ae8fae78ecee69294d552b764dbcd6f8735d0a9c9be20ab0c82"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HTTP Content Range response header parser"
HOMEPAGE="https://github.com/nyurik/http-content-range"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
