# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro2"
CRATE_VERSION="1.0.103"
CRATE_CHECKSUM="5ee95bc4ef87b8d5ba32e8b7714ccc834865276eab0aed5c9958d00ec45f49e8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A substitute implementation of the compiler's \`proc_macro\` API to decouple token-based libraries from the procedural macro use case."
HOMEPAGE="https://github.com/dtolnay/proc-macro2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"proc-macro"
	"span-locations"
)
