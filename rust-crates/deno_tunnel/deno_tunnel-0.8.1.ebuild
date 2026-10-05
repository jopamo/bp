# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_tunnel"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="e432929e0c167f2a003b963ee406c714fcd947a87d4f9edc7b3255e87be9881d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Deno Tunnels"
HOMEPAGE="https://github.com/denoland/deno_tunnel"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
