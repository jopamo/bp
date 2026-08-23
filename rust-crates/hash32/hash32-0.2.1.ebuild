# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="hash32"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="b0c35f58762feb77d74ebe43bdbc3210f09be9fe6742234d573bacc26ed92b67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="32-bit hashing machinery"
HOMEPAGE="https://github.com/japaric/hash32"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
