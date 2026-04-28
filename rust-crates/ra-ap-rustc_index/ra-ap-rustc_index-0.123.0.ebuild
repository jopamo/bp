# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra-ap-rustc_index"
CRATE_VERSION="0.123.0"
CRATE_CHECKSUM="57a24fe0be21be1f8ebc21dcb40129214fb4cefb0f2753f3d46b6dbe656a1a45"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Automatically published version of the package `rustc_index` in the rust-lang/rust repository from commit 052114f0c5e8d49f62f8caba364b07017310ab09 The publishing script for this crate lives at: https://github.com/rust-analyzer/rustc-auto-publish"
HOMEPAGE="https://github.com/rust-lang/rust"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"nightly"
	"rustc_randomized_layouts"
)
