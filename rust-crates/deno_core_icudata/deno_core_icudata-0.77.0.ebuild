# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_core_icudata"
CRATE_VERSION="0.77.0"
CRATE_CHECKSUM="a9efff8990a82c1ae664292507e1a5c6749ddd2312898cdf9cd7cb1fd4bc64c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw ICU data for use with deno_core"
HOMEPAGE="https://github.com/denoland/deno_core_icudata"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
