# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xattr"
CRATE_VERSION="1.6.1"
CRATE_CHECKSUM="32e45ad4206f6d2479085147f02bc2ef834ac85886624a23575ae137c8aa8156"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="unix extended filesystem attributes"
HOMEPAGE="https://github.com/Stebalien/xattr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unsupported"
)
