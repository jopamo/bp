# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="syn-match"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="54b8f0a9004d6aafa6a588602a1119e6cdaacec9921aa1605383e6e7d6258fd6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="a macro for matching on syn paths"
HOMEPAGE="https://github.com/crowlKats/syn-match"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
