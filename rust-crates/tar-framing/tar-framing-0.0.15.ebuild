# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tar-framing"
CRATE_VERSION="0.0.15"
CRATE_CHECKSUM="563e8181b47c9cdcce569eae3ad431eec71543d6269dd60c7bd2350f70bcd233"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A framing layer for tar archives."
HOMEPAGE="https://github.com/astral-sh/astral-codec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
