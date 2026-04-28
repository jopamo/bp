# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustyline-derive"
CRATE_VERSION="0.7.0"
CRATE_CHECKSUM="107c3d5d7f370ac09efa62a78375f94d94b8a33c61d8c278b96683fb4dbf2d8d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rustyline macros implementation of #[derive(Completer, Helper, Hinter, Highlighter)]"
HOMEPAGE="https://github.com/kkawakam/rustyline"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
