# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_sourcemap"
CRATE_VERSION="9.3.4"
CRATE_CHECKSUM="de08ef00f816acdd1a58ee8a81c0e1a59eefef2093aefe5611f256fa6b64c4d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Forked from https://github.com/getsentry/rust-sourcemap"
HOMEPAGE="https://github.com/swc-project/swc-sourcemap"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"ram_bundle"
)
