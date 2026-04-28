# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="form_urlencoded"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="e13624c2627564efccf4934284bdd98cbaa14e79b0b5a141218e507b3a823456"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser and serializer for the application/x-www-form-urlencoded syntax, as used by HTML forms."
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
