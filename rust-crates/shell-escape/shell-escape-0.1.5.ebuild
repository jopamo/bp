# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="shell-escape"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="45bb67a18fa91266cc7807181f62f9178a6873bfad7dc788c42e6430db40184f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Escape characters that may have a special meaning in a shell"
HOMEPAGE="https://github.com/sfackler/shell-escape"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
