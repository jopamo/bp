# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="axotag"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="dc923121fbc4cc72e9008436b5650b98e56f94b5799df59a1b4f572b5c6a7e6b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to share tag-parsing code between axodotdev projects"
HOMEPAGE="https://github.com/axodotdev/axotag"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
