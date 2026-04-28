# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_path_util"
CRATE_VERSION="0.6.4"
CRATE_CHECKSUM="78c7e98943f0d068928906db0c7bde89de684fa32c6a8018caacc4cee2cdd72b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Path utilities used in Deno"
HOMEPAGE="https://github.com/denoland/deno_path_util"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
