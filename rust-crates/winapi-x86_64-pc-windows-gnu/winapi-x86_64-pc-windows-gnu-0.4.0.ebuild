# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="winapi-x86_64-pc-windows-gnu"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import libraries for the x86_64-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead."
HOMEPAGE="https://github.com/retep998/winapi-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
