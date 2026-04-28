# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="line-index"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="3e27e0ed5a392a7f5ba0b3808a2afccff16c64933312c84b57618b49d1209bd2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Maps flat \`TextSize\` offsets to/from \`(line, column)\` representation."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer/tree/master/lib/line-index"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
