# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ref-cast"
CRATE_VERSION="1.0.24"
CRATE_CHECKSUM="4a0ae411dbe946a674d89546582cea4ba2bb8defac896622d6496f14c23ba5cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safely cast &T to &U where the struct U contains a single field of type T."
HOMEPAGE="https://github.com/dtolnay/ref-cast"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
