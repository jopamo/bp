# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dhat"
CRATE_VERSION="0.3.3"
CRATE_CHECKSUM="98cd11d84628e233de0ce467de10b8633f4ddaecafadefc86e13b84b8739b827"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for heap profiling and ad hoc profiling with DHAT."
HOMEPAGE="https://github.com/nnethercote/dhat-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
