# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-platform-verifier-android"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="f87165f0995f63a9fbeea62b64d10b4d9d8e78ec6d7d51fb2125fda7bb36788f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The internal JVM support component of the rustls-platform-verifier crate. You shouldn't depend on this directly."
HOMEPAGE="https://github.com/rustls/rustls-platform-verifier"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
