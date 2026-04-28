# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ra_ap_hir_def"
CRATE_VERSION="0.0.301"
CRATE_CHECKSUM="81d2337ef59550392d42aa997aa1105a3d6d1c2b3a583c777786bc4a0a074fd5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="RPC Api for the \`proc-macro-srv\` crate of rust-analyzer."
HOMEPAGE="https://github.com/rust-lang/rust-analyzer"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"in-rust-tree"
)
