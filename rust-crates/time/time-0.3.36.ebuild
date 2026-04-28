# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="time"
CRATE_VERSION="0.3.36"
CRATE_CHECKSUM="5dfd88e563464686c916c7e46e623e520ddc6d79fa6641390f2e3fa86e83e885"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Date and time library. Fully interoperable with the standard library. Mostly compatible with #![no_std]."
HOMEPAGE="https://time-rs.github.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"formatting"
	"large-dates"
	"local-offset"
	"macros"
	"parsing"
	"quickcheck"
	"rand"
	"serde"
	"serde-human-readable"
	"serde-well-known"
	"std"
	"wasm-bindgen"
)
