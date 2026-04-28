# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc-hash"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="08d43f7aa6b08d49f382cde6a7982047c3426db949b1424bc4b7ec9ae12c6ce2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="speed, non-cryptographic hash used in rustc"
HOMEPAGE="https://github.com/rust-lang-nursery/rustc-hash"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
