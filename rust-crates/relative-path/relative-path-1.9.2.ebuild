# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="relative-path"
CRATE_VERSION="1.9.2"
CRATE_CHECKSUM="e898588f33fdd5b9420719948f9f2a32c922a246964576f71ba7f24f80610fbc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable, relative paths for Rust."
HOMEPAGE="https://github.com/udoprog/relative-path"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
)
