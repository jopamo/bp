# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rustyline-derive"
CRATE_VERSION="0.11.1"
CRATE_CHECKSUM="5d66de233f908aebf9cc30ac75ef9103185b4b715c6f2fb7a626aa5e5ede53ab"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustyline macros implementation of #[derive(Completer, Helper, Hinter, Highlighter)]"
HOMEPAGE="https://github.com/kkawakam/rustyline"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
