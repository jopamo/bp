# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="mailparse"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="068d4f5d1083883b9e626051dc5bdaa321f5be01093e61ade3ee3ab44dafeadd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple parser for MIME e-mail messages"
HOMEPAGE="https://github.com/staktrace/mailparse/blob/master/README.md"
LICENSE="0BSD"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
