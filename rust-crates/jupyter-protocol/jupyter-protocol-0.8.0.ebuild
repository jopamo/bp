# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jupyter-protocol"
CRATE_VERSION="0.8.0"
CRATE_CHECKSUM="815c1eb9089b035c7c89932beaba6f4daabc8efa198960492636c7eb45d0ebde"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Jupyter messaging structures and traits for jupyter clients and servers"
HOMEPAGE="https://github.com/runtimed/runtimed"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
