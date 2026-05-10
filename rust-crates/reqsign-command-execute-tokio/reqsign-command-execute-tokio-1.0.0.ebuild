# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign-command-execute-tokio"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="8e145d2d409f3db11aa3094b8905d69b084d4060771c12e6522dde55924bfecd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Tokio-based command execution implementation for reqsign"
HOMEPAGE="https://github.com/Xuanwo/reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
