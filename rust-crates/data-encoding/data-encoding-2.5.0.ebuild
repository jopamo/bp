# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="data-encoding"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="7e962a19be5cfc3f3bf6dd8f61eb50107f356ad6270fbb3ed41476571db78be5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Efficient and customizable data-encoding functions like base64, base32, and hex"
HOMEPAGE="https://github.com/ia0/data-encoding"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
