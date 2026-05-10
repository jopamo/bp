# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="unicode-bidi-mirroring"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="56d12260fb92d52f9008be7e4bca09f584780eb2266dc8fecc6a192bec561694"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unicode Bidi Mirroring propery detection"
HOMEPAGE="https://github.com/RazrFalcon/unicode-bidi-mirroring"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
