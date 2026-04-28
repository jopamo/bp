# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ahash"
CRATE_VERSION="0.8.12"
CRATE_CHECKSUM="5a15f179cd60c4584b8a8c596927aadc462e27f2ca70c04e0071964a73ba7a75"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A non-cryptographic hash function using AES-NI for high performance"
HOMEPAGE="https://github.com/tkaitchuck/ahash"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"atomic-polyfill"
	"compile-time-rng"
	"default"
	"nightly-arm-aes"
	"no-rng"
	"runtime-rng"
	"std"
)
