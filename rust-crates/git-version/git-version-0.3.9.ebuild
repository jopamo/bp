# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="git-version"
CRATE_VERSION="0.3.9"
CRATE_CHECKSUM="1ad568aa3db0fcbc81f2f116137f263d7304f512a1209b35b85150d3ef88ad19"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compile the git version (tag name, or hash otherwise) and dirty state into your program."
HOMEPAGE="https://github.com/fusion-engineering/rust-git-version"
LICENSE="BSD-2-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
