# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="find-msvc-tools"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="7fd99930f64d146689264c637b5af2f0233a933bef0d8570e2526bf9e083192d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Find windows-specific tools, read MSVC versions from the registry and from COM interfaces"
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
