# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_semver"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="2625b7107cc3f61a462886d5fa77c23e063c1fd15b90e3d5ee2646e9f6178d55"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Semver for Deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
