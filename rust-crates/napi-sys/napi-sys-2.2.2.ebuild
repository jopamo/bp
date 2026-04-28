# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="napi-sys"
CRATE_VERSION="2.2.2"
CRATE_CHECKSUM="529671ebfae679f2ce9630b62dd53c72c56b3eb8b2c852e7e2fa91704ff93d67"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="NodeJS N-API raw binding"
HOMEPAGE="https://github.com/napi-rs/napi-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"experimental"
	"napi1"
	"napi2"
	"napi3"
	"napi4"
	"napi5"
	"napi6"
	"napi7"
	"napi8"
)
