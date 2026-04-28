# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="insta"
CRATE_VERSION="1.43.2"
CRATE_CHECKSUM="46fdb647ebde000f43b5b53f773c30cf9b0cb4300453208713fa38b2c70935a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A snapshot testing library for Rust"
HOMEPAGE="https://insta.rs/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"_cargo_insta_internal"
	"colors"
	"csv"
	"default"
	"filters"
	"glob"
	"json"
	"redactions"
	"ron"
	"toml"
	"yaml"
)
