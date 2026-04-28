# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dunce"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="92773504d58c093f6de2459af4af33faa518c13451eb8f2b5698ed3d36e7c813"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Normalize Windows paths to the most compatible format, avoiding UNC where possible"
HOMEPAGE="https://lib.rs/crates/dunce"
LICENSE="|| ( CC0-1.0 MIT-0 Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
