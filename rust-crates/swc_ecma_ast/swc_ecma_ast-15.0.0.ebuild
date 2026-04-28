# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="swc_ecma_ast"
CRATE_VERSION="15.0.0"
CRATE_CHECKSUM="65c25af97d53cf8aab66a6c68f3418663313fc969ad267fc2a4d19402c329be1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Ecmascript ast."
HOMEPAGE="https://github.com/swc-project/swc.git"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"__rkyv"
	"default"
	"fuzzing"
	"rkyv-impl"
	"serde-impl"
	"shrink-to-fit"
)
