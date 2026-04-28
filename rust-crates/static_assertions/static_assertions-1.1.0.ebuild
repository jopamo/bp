# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="static_assertions"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Compile-time assertions to ensure that invariants are met."
HOMEPAGE="https://github.com/nvzqz/static-assertions-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
