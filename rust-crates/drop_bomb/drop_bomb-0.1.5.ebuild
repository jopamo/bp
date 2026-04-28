# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="drop_bomb"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="9bda8e21c04aca2ae33ffc2fd8c23134f3cac46db123ba97bd9d3f3b8a4a85e1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A runtime guard for implementing linear types."
HOMEPAGE="https://github.com/matklad/drop_bomb"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
