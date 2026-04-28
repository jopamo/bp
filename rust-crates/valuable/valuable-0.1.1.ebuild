# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="valuable"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="ba73ea9cf16a25df0c8caa16c51acb937d5712a8429db78a3ee29d5dcacd3a65"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Object-safe value inspection, used to pass un-typed structured data across trait-object boundaries."
HOMEPAGE="https://github.com/tokio-rs/valuable"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
	"std"
)
