# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="filetime"
CRATE_VERSION="0.2.29"
CRATE_CHECKSUM="5c287a33c7f0a620c38e641e7f60827713987b3c0f26e8ddc9462cc69cf75759"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Platform-agnostic accessors of timestamps in File metadata"
HOMEPAGE="https://github.com/alexcrichton/filetime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
