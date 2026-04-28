# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rend"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="71fe3824f5629716b1589be05dacd749f6aa084c87e00e016714a8cdfccc997c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Endian-aware primitives for Rust"
HOMEPAGE="https://github.com/djkoloski/rend"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"validation"
)
