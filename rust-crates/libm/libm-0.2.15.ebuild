# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libm"
CRATE_VERSION="0.2.15"
CRATE_CHECKSUM="f9fbbcab51052fe104eb5e5d351cf728d30a5be1fe14d9be8a3b097481fb97de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="libm in pure Rust"
HOMEPAGE="https://github.com/rust-lang/compiler-builtins"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"arch"
	"default"
	"force-soft-floats"
	"unstable"
	"unstable-float"
	"unstable-intrinsics"
	"unstable-public-internals"
)
