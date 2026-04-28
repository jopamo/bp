# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fuchsia-cprng"
CRATE_VERSION="0.1.1"
CRATE_CHECKSUM="a06f77d526c1a601b7c4cdd98f54b5eaabffc14d5f2f0296febdc7f357c6d3ba"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust crate for the Fuchsia cryptographically secure pseudorandom number generator"
HOMEPAGE="https://fuchsia.googlesource.com/fuchsia/+/master/garnet/public/rust/fuchsia-cprng"
LICENSE="non-standard"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
