# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="unindent"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="7264e107f553ccae879d21fbea1d6724ac785e8c3bfc762137959b5802826ef3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Remove a column of leading whitespace from a string"
HOMEPAGE="https://github.com/dtolnay/indoc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
