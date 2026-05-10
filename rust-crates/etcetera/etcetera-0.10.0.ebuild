# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="etcetera"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="26c7b13d0780cb82722fd59f6f57f925e143427e4a75313a6c77243bf5326ae6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An unopinionated library for obtaining configuration, data, cache, & other directories"
HOMEPAGE="https://github.com/lunacookies/etcetera"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
