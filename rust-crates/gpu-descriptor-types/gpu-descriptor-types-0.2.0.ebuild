# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="gpu-descriptor-types"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="fdf242682df893b86f33a73828fb09ca4b2d3bb6cc95249707fc684d27484b91"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core types of gpu-descriptor crate"
HOMEPAGE="https://github.com/zakarumych/gpu-descriptor"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
