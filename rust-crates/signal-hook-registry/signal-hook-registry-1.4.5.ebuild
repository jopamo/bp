# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="signal-hook-registry"
CRATE_VERSION="1.4.5"
CRATE_CHECKSUM="9203b8055f63a2a00e2f593bb0510367fe707d7ff1e5c872de2f537b339e5410"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backend crate for signal-hook"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
