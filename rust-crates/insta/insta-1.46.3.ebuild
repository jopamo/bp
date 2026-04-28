# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="insta"
CRATE_VERSION="1.46.3"
CRATE_CHECKSUM="e82db8c87c7f1ccecb34ce0c24399b8a73081427f3c7c50a5d597925356115e4"
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
