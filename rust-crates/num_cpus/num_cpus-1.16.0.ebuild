# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num_cpus"
CRATE_VERSION="1.16.0"
CRATE_CHECKSUM="4161fcb6d602d4d2081af7c3a45852d875a03dd337a6bfdd6e06407b61342a43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Get the number of CPUs on a machine."
HOMEPAGE="https://github.com/seanmonstar/num_cpus"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
