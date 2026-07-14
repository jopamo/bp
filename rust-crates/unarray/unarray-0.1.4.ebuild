# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unarray"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="eaea85b334db583fe3274d12b4cd1880032beab409c0d774be044d4480ab9a94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for working with uninitialized arrays"
HOMEPAGE="https://github.com/cameron1024/unarray"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
