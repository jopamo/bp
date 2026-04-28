# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_codegen"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="aef8048c789fa5e851558d709946d6d79a8ff88c0440c587967f8e94bfb1216a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Codegen library for PHF types"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
