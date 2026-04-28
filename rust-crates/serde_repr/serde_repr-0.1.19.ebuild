# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_repr"
CRATE_VERSION="0.1.19"
CRATE_CHECKSUM="6c64451ba24fc7a6a2d60fc75dd9c83c90903b19028d4eff35e88fc1e86564e9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive Serialize and Deserialize that delegates to the underlying repr of a C-like enum."
HOMEPAGE="https://github.com/dtolnay/serde-repr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
