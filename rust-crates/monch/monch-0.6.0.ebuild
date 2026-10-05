# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="monch"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="6bcc6ad3b93f756f2532d29f7c7291b8d246a2c460a99a3611327bb726830014"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Inspired by nom, but specifically for strings."
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
