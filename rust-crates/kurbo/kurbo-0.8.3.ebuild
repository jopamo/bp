# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="kurbo"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="7a53776d271cfb873b17c618af0298445c88afc52837f3e948fa3fafd131f449"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A 2D curves library"
HOMEPAGE="https://github.com/linebender/kurbo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
