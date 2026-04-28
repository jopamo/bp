# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thin-vec"
CRATE_VERSION="0.2.14"
CRATE_CHECKSUM="144f754d318415ac792f9d69fc87abbbfc043ce2ef041c60f16ad828f638717d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A vec that takes up less space on the stack"
HOMEPAGE="https://github.com/gankra/thin-vec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"gecko-ffi"
	"std"
	"unstable"
)
