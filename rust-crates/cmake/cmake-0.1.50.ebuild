# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cmake"
CRATE_VERSION="0.1.50"
CRATE_CHECKSUM="a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A build dependency for running \`cmake\` to build a native library"
HOMEPAGE="https://github.com/rust-lang/cmake-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
