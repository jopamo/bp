# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="filetime"
CRATE_VERSION="0.2.28"
CRATE_CHECKSUM="2d5b2eef6fafbf69f877e55509ce5b11a760690ac9700a2921be067aa6afaef6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Platform-agnostic accessors of timestamps in File metadata"
HOMEPAGE="https://github.com/alexcrichton/filetime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
