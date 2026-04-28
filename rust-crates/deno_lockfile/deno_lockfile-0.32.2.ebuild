# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_lockfile"
CRATE_VERSION="0.32.2"
CRATE_CHECKSUM="3d71c0df1464034be21a9472e7ec8f9a21958418d203fa2c40507fb5cafe799d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of a lockfile used in Deno"
HOMEPAGE="https://github.com/denoland/deno_lockfile"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
