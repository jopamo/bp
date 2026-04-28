# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jni"
CRATE_VERSION="0.21.1"
CRATE_CHECKSUM="1a87aa2bb7d2af34197c04845522473242e1aa17c12f4935d5856491a7fb8c97"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings to the JNI"
HOMEPAGE="https://github.com/jni-rs/jni-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"invocation"
)
