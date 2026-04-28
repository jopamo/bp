# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thiserror"
CRATE_VERSION="1.0.69"
CRATE_CHECKSUM="b6aaf5339b578ea85b50e080feb250a3e8ae8cfcdff9a461c9ec2904bc923f52"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="derive(Error)"
HOMEPAGE="https://github.com/dtolnay/thiserror"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
