# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="libm"
CRATE_VERSION="0.2.16"
CRATE_CHECKSUM="b6d2cec3eae94f9f509c767b45932f1ada8350c4bdb85af2fcab4a3c14807981"
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
