# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="itoa"
CRATE_VERSION="1.0.11"
CRATE_CHECKSUM="49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast integer primitive to string conversion"
HOMEPAGE="https://github.com/dtolnay/itoa"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
