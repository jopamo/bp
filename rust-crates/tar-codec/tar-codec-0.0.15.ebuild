# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tar-codec"
CRATE_VERSION="0.0.15"
CRATE_CHECKSUM="b9dad615e50d181afea4bafea23dacb8e33ed52dde06503813570634b932d467"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="tar-codec is a small, fast, constrained tar encoder and decoder for Rust"
HOMEPAGE="https://github.com/astral-sh/astral-codec"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
