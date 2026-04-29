# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="r-efi"
CRATE_VERSION="6.0.0"
CRATE_CHECKSUM="f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UEFI Reference Specification Protocol Constants and Definitions"
HOMEPAGE="https://github.com/r-efi/r-efi/wiki"
LICENSE="|| ( MIT Apache-2.0 LGPL-2.1-or-later )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"native"
	"rustc-dep-of-std"
)
