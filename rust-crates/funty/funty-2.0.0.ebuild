# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="funty"
CRATE_VERSION="2.0.0"
CRATE_CHECKSUM="e6d5a32815ae3f33302d95fdcb2ce17862f8c65363dcfd29360480ba1001fc9c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Trait generalization over the primitive types"
HOMEPAGE="https://github.com/myrrlyn/funty"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
