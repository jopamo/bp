# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_error"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="dde60bd153886964234c5012d3d9caf788287f28d81fb24a884436904101ef10"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Error representation to JavaScript for deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
