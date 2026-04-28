# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_native_certs"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="c867603d2a5dfea31f55cecebb572554caa395437786d058faa9a2814c8d6eb9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="deno-native-certs loads native certificate store into rustls"
HOMEPAGE="https://github.com/denoland/deno_native_certs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
