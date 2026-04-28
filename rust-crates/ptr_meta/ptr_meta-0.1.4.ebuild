# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ptr_meta"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="0738ccf7ea06b608c10564b31debd4f5bc5e197fc8bfe088f68ae5ce81e7a4f1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A radioactive stabilization of the ptr_meta rfc"
HOMEPAGE="https://github.com/djkoloski/ptr_meta"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
