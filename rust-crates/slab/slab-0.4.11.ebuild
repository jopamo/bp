# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="slab"
CRATE_VERSION="0.4.11"
CRATE_CHECKSUM="7a2ae44ef20feb57a68b23d846850f861394c2e02dc425a50098ae8c90267589"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pre-allocated storage for a uniform data type"
HOMEPAGE="https://github.com/tokio-rs/slab"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
