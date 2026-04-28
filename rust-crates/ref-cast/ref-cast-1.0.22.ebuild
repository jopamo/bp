# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ref-cast"
CRATE_VERSION="1.0.22"
CRATE_CHECKSUM="c4846d4c50d1721b1a3bef8af76924eef20d5e723647333798c1b519b3a9473f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safely cast &T to &U where the struct U contains a single field of type T."
HOMEPAGE="https://github.com/dtolnay/ref-cast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
