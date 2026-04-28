# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num_cpus"
CRATE_VERSION="1.17.0"
CRATE_CHECKSUM="91df4bbde75afed763b708b7eee1e8e7651e02d97f6d5dd763e89367e957b23b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Get the number of CPUs on a machine."
HOMEPAGE="https://github.com/seanmonstar/num_cpus"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
