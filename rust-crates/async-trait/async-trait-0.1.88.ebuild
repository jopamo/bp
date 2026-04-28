# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="async-trait"
CRATE_VERSION="0.1.88"
CRATE_CHECKSUM="e539d3fca749fcee5236ab05e93a52867dd549cc157c8cb7f99595f3cedffdb5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Type erasure for async trait methods"
HOMEPAGE="https://github.com/dtolnay/async-trait"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
