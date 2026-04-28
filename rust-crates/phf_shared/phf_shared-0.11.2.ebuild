# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_shared"
CRATE_VERSION="0.11.2"
CRATE_CHECKSUM="90fcb95eef784c2ac79119d1dd819e162b5da872ce6f3c3abe1e8ca1c082f72b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Support code shared by PHF libraries"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
