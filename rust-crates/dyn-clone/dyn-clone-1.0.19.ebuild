# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="dyn-clone"
CRATE_VERSION="1.0.19"
CRATE_CHECKSUM="1c7a8fb8a9fbf66c1f703fe16184d10ca0ee9d23be5b4436400408ba54a95005"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Clone trait that is dyn-compatible"
HOMEPAGE="https://github.com/dtolnay/dyn-clone"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
