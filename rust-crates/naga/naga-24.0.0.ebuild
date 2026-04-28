# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="naga"
CRATE_VERSION="24.0.0"
CRATE_CHECKSUM="e380993072e52eef724eddfcde0ed013b0c023c3f0417336ed041aa9f076994e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shader translator and validator. Part of the wgpu project"
HOMEPAGE="https://github.com/gfx-rs/wgpu/tree/trunk/naga"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"compact"
	"default"
	"deserialize"
	"dot-out"
	"glsl-in"
	"glsl-out"
	"hlsl-out"
	"hlsl-out-if-target-windows"
	"msl-out"
	"msl-out-if-target-apple"
	"serialize"
	"spv-in"
	"spv-out"
	"wgsl-in"
	"wgsl-out"
)
