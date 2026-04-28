# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="glow"
CRATE_VERSION="0.16.0"
CRATE_CHECKSUM="c5e5ea60d70410161c8bf5da3fdfeaa1c72ed2c15f8bbb9d19fe3a4fad085f08"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="GL on Whatever: a set of bindings to run GL (Open GL, OpenGL ES, and WebGL) anywhere, and avoid target-specific code."
HOMEPAGE="https://github.com/grovesNL/glow.git"
LICENSE="|| ( MIT Apache-2.0 Zlib )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug_automatic_glGetError"
	"debug_trace_calls"
)
