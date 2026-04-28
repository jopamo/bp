# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustc-hash"
CRATE_VERSION="2.1.1"
CRATE_CHECKSUM="357703d41365b4b27c590e3ed91eabb1b663f07c4c084095e60cbed4362dff0d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A speedy, non-cryptographic hashing algorithm used by rustc"
HOMEPAGE="https://github.com/rust-lang/rustc-hash"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"rand"
	"std"
)
