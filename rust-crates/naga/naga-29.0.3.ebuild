# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="naga"
CRATE_VERSION="29.0.3"
CRATE_CHECKSUM="0dd91265cc2454558f659b3b4b9640f0ddb8cc6521277f166b8a8c181c898079"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shader translator and validator. Part of the wgpu project"
HOMEPAGE="https://github.com/gfx-rs/wgpu"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arbitrary"
	"default"
	"deserialize"
	"dot-out"
	"fs"
	"glsl-in"
	"glsl-out"
	"hlsl-out"
	"hlsl-out-if-target-windows"
	"msl-out"
	"msl-out-if-target-apple"
	"serialize"
	"spv-in"
	"spv-out"
	"stderr"
	"termcolor"
	"wgsl-in"
	"wgsl-out"
)
