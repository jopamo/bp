# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="scoped-tls"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="e1cf6437eb19a8f4a6cc0f7dca544973b0b78843adbfeb3683d1a94a0024a294"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library implementation of the standard library's old \`scoped_thread_local!\` macro for providing scoped access to thread local storage (TLS) so any type can be stored into TLS."
HOMEPAGE="https://github.com/alexcrichton/scoped-tls"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
