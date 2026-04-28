# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="phf_generator"
CRATE_VERSION="0.11.3"
CRATE_CHECKSUM="3c80231409c20246a13fddb31776fb942c38553c51e871f8cbd687a4cfb5843d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="PHF generation logic"
HOMEPAGE="https://github.com/rust-phf/rust-phf"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
