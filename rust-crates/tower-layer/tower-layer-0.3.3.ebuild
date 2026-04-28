# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="tower-layer"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="121c2a6cda46980bb0fcd1647ffaf6cd3fc79a013de288782836f6df9c48780e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Decorates a \`Service\` to allow easy composition between \`Service\`s."
HOMEPAGE="https://github.com/tower-rs/tower"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
