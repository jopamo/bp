# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="cfb"
CRATE_VERSION="0.14.0"
CRATE_CHECKSUM="a347dcabdae9c31b0825fd6a8bed285ec9c2acb89c47827126d52fa4f59cece3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Read/write Compound File Binary (structured storage) files"
HOMEPAGE="https://github.com/mdsteele/rust-cfb"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
