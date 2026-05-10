# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="munge"
CRATE_VERSION="0.4.5"
CRATE_CHECKSUM="9cce144fab80fbb74ec5b89d1ca9d41ddf6b644ab7e986f7d3ed0aab31625cb1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macro for custom destructuring"
HOMEPAGE="https://github.com/djkoloski/munge"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
