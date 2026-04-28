# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="monch"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="b52c1b33ff98142aecea13138bd399b68aa7ab5d9546c300988c345004001eea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Inspired by nom, but specifically for strings."
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
