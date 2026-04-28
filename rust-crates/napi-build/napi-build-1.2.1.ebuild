# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="napi-build"
CRATE_VERSION="1.2.1"
CRATE_CHECKSUM="ebd4419172727423cf30351406c54f6cc1b354a2cfb4f1dba3e6cd07f6d5522b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="N-API build support"
HOMEPAGE="https://github.com/napi-rs/napi-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
