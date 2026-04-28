# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="valuable"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="830b7e5d4d90034032940e4ace0d9a9a057e7a45cd94e6c007832e39edb82f6d"
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
