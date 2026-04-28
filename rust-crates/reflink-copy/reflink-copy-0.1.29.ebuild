# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="reflink-copy"
CRATE_VERSION="0.1.29"
CRATE_CHECKSUM="13362233b147e57674c37b802d216b7c5e3dcccbed8967c84f0d8d223868ae27"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="copy-on-write mechanism on supported file systems"
HOMEPAGE="https://github.com/cargo-bins/reflink-copy"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"tracing"
)
