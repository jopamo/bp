# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ahash"
CRATE_VERSION="0.8.11"
CRATE_CHECKSUM="e89da841a80418a9b391ebaea17f5c112ffaaa96f621d2c285b5174da76b9011"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A non-cryptographic hash function using AES-NI for high performance"
HOMEPAGE="https://github.com/tkaitchuck/ahash"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"atomic-polyfill"
	"compile-time-rng"
	"default"
	"nightly-arm-aes"
	"no-rng"
	"runtime-rng"
	"std"
)
