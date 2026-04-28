# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_unsync"
CRATE_VERSION="0.4.4"
CRATE_CHECKSUM="6742a724e8becb372a74c650a1aefb8924a5b8107f7d75b3848763ea24b27a87"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of adapters to make working with Tokio single-threaded runtimes easier"
HOMEPAGE="https://github.com/denoland/deno_unsync"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"tokio"
)
