# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ash"
CRATE_VERSION="0.38.0+1.3.281"
CRATE_CHECKSUM="0bb44936d800fea8f016d7f2311c6a4f97aebd5dc86f09906139ec848cf3a46f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Vulkan bindings for Rust"
HOMEPAGE="https://github.com/ash-rs/ash"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"linked"
	"loaded"
	"std"
)
