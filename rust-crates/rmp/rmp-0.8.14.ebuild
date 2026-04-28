# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rmp"
CRATE_VERSION="0.8.14"
CRATE_CHECKSUM="228ed7c16fa39782c3b3468e974aec2795e9089153cd08ee2e9aefb3613334c4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust MessagePack serialization implementation"
HOMEPAGE="https://github.com/3Hren/msgpack-rust"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
