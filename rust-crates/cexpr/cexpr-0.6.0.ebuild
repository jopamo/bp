# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cexpr"
CRATE_VERSION="0.6.0"
CRATE_CHECKSUM="6fac387a98bb7c37292057cffc56d62ecb629900026402633ae9160df93a8766"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A C expression parser and evaluator"
HOMEPAGE="https://github.com/jethrogb/rust-cexpr"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
