# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-command-execute-tokio"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="38b53d033600f533135afec8e97be99c80fcf8177f6285da6c7300955d5377a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tokio-based command execution implementation for reqsign"
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
