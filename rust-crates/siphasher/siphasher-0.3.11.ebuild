# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="siphasher"
CRATE_VERSION="0.3.11"
CRATE_CHECKSUM="38b58827f4464d87d377d175e90bf58eb00fd8716ff0a62f80356b5e61555d0d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SipHash-2-4, SipHash-1-3 and 128-bit variants in pure Rust"
HOMEPAGE="https://docs.rs/siphasher"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde_no_std"
	"serde_std"
	"std"
)
