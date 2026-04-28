# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_tunnel"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="cbe45dacb6e0d2a646b22a12fea81ba2f7128202f9ee91602782b9208da123b9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Deno Tunnels"
HOMEPAGE="https://github.com/denoland/deno_tunnel"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
