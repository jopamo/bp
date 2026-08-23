# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="num_threads"
CRATE_VERSION="0.1.7"
CRATE_CHECKSUM="5c7398b9c8b70908f6371f47ed36737907c87c52af34c268fed0bf0ceb92ead9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A minimal library that determines the number of running threads for the current process."
HOMEPAGE="https://github.com/jhpratt/num_threads"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
