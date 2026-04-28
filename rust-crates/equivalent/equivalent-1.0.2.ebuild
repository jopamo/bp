# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="equivalent"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits for key comparison in maps."
HOMEPAGE="https://github.com/indexmap-rs/equivalent"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
