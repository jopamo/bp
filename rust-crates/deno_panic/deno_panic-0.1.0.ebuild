# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_panic"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="032c5c8f43f1402273f4cd1ca133931b3da094fa167406b6dec5875982e18969"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="stack trace and symbolication for deno"
HOMEPAGE="https://github.com/denoland/panic"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"symbolicate"
)
