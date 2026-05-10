# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="secrecy"
CRATE_VERSION="0.10.3"
CRATE_CHECKSUM="e891af845473308773346dc847b2c23ee78fe442e0472ac50e22a18a93d3ae5a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Wrapper types and traits for secret management which help ensure they aren't accidentally copied, logged, or otherwise exposed (as much as possible), and also ensure secrets are securely wiped from memory when dropped."
HOMEPAGE="https://github.com/iqlusioninc/crates/"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
