# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_ops"
CRATE_VERSION="0.239.0"
CRATE_CHECKSUM="2fcc6e51a8af86a5abe8466781b63fc2d96cd49897d3532402e84f1d0a216113"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Proc macro for writing Deno Ops"
HOMEPAGE="https://github.com/denoland/deno_core"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
