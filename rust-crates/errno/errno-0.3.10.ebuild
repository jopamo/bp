# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="errno"
CRATE_VERSION="0.3.10"
CRATE_CHECKSUM="33d852cb9b869c2a9b3df2f71a3074817f01e1844f839a144f5fcef059a4eb5d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform interface to the `errno` variable."
HOMEPAGE="https://github.com/lambda-fairy/rust-errno"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
