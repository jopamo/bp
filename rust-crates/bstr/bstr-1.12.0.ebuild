# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bstr"
CRATE_VERSION="1.12.0"
CRATE_CHECKSUM="234113d19d0d7d613b40e86fb654acf958910802bcceab913a4f9e7cda03b1a4"
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
