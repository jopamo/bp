# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gpu-descriptor"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="9c08c1f623a8d0b722b8b99f821eb0ba672a1618f0d3b16ddbee1cedd2dd8557"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation agnostic descriptor allocator for Vulkan like APIs"
HOMEPAGE="https://github.com/zakarumych/gpu-descriptor"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
