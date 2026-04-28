# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-platform"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="84982c6c0ae343635a3a4ee6dedef965513735c8b183caa7289fa6e27399ebd4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cargo's representation of a target platform."
HOMEPAGE="https://github.com/rust-lang/cargo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
