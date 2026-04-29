# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro2"
CRATE_VERSION="1.0.81"
CRATE_CHECKSUM="3d1597b0c024618f09a9c3b8655b7e430397a36d23fdafec26d6965e9eec3eba"
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
