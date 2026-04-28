# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bstr"
CRATE_VERSION="1.9.1"
CRATE_CHECKSUM="05efc5cfd9110c8416e471df0e96702d58690178e206e61b7173706673c93706"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A string type that is not required to be valid UTF-8."
HOMEPAGE="https://github.com/BurntSushi/bstr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde"
	"std"
	"unicode"
)
