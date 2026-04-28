# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="form_urlencoded"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser and serializer for the application/x-www-form-urlencoded syntax, as used by HTML forms."
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
