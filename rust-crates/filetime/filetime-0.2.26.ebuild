# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="filetime"
CRATE_VERSION="0.2.26"
CRATE_CHECKSUM="bc0505cd1b6fa6580283f6bdf70a73fcf4aba1184038c90902b92b3dd0df63ed"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Platform-agnostic accessors of timestamps in File metadata"
HOMEPAGE="https://github.com/alexcrichton/filetime"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
