# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashbrown"
CRATE_VERSION="0.15.5"
CRATE_CHECKSUM="9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust port of Google's SwissTable hash map"
HOMEPAGE="https://github.com/rust-lang/hashbrown"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"default-hasher"
	"inline-more"
	"nightly"
	"raw-entry"
	"rustc-dep-of-std"
	"rustc-internal-api"
)
