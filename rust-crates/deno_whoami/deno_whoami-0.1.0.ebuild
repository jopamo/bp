# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_whoami"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="e75e4caa92b98a27f09c671d1399aee0f5970aa491b9a598523aac000a2192e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate implements the username() API in Deno Node compat layer."
HOMEPAGE="https://crates.io/crates/deno_whoami"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
