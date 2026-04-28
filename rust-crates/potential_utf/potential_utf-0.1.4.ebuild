# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="potential_utf"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="b73949432f5e2a09657003c25bca5e19a0e9c84f8058ca374f49e0ebe605af77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Unvalidated string and character types"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"databake"
	"default"
	"serde"
	"writeable"
	"zerovec"
)
