# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rayon-cond"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="2964d0cf57a3e7a06e8183d14a8b527195c706b7983549cd5462d5aa3747438f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Experimental iterator wrapper that is conditionally parallel or serial."
HOMEPAGE="https://github.com/cuviper/rayon-cond"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
