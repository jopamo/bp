# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="proc-macro2"
CRATE_VERSION="1.0.86"
CRATE_CHECKSUM="5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A substitute implementation of the compiler's \`proc_macro\` API to decouple token-based libraries from the procedural macro use case."
HOMEPAGE="https://github.com/dtolnay/proc-macro2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"proc-macro"
	"span-locations"
)
