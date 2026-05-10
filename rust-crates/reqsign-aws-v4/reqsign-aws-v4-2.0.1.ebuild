# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-aws-v4"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="4510c2a3e42b653cf788d560a3d54b0ae4cc315a62aaba773554f18319c0db0b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="AWS SigV4 signing implementation for reqsign."
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
