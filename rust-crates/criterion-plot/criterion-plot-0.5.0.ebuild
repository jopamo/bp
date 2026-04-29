# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="criterion-plot"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="6b50826342786a51a89e2da3a28f1c32b06e387201bc2d19791f622c673706b1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Criterion's plotting library"
HOMEPAGE="https://github.com/bheisler/criterion.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
