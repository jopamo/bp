# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="icu_properties"
CRATE_VERSION="1.5.1"
CRATE_CHECKSUM="93d6020766cfc6302c15dbbc9c8778c37e62c14427cb7f6e601d849e092aeef5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Definitions for Unicode properties"
HOMEPAGE="https://icu4x.unicode.org"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bidi"
	"compiled_data"
	"datagen"
	"default"
	"serde"
	"std"
)
