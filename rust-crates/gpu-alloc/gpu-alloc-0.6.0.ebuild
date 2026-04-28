# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gpu-alloc"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="fbcd2dba93594b227a1f57ee09b8b9da8892c34d55aa332e034a228d0fe6a171"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation agnostic memory allocator for Vulkan like APIs"
HOMEPAGE="https://github.com/zakarumych/gpu-alloc"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
