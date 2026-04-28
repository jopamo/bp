# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sptr"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="3b9b39299b249ad65f3b7e96443bad61c02ca5cd3589f46cb6d610a0fd6c0d6a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="sptr: The Strict Provenance Polyfill"
HOMEPAGE="https://github.com/Gankra/sptr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"opaque_fn"
	"uptr"
)
