# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc-stable-hash"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="781442f29170c5c93b7185ad559492601acdc71d5bb0706f5868094f45cfcd08"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A stable hashing algorithm used by rustc"
HOMEPAGE="https://github.com/rust-lang/rustc-stable-hash"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"nightly"
)
