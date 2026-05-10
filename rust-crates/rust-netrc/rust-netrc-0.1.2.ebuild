# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rust-netrc"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="7e98097f62769f92dbf95fb51f71c0a68ec18a4ee2e70e0d3e4f47ac005d63e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="netrc support for Rust with support for reqwest"
HOMEPAGE="https://github.com/gribouille/netrc"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
