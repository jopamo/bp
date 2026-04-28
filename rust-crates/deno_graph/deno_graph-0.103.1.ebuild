# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_graph"
CRATE_VERSION="0.103.1"
CRATE_CHECKSUM="293db685464cf8a18785e32d6fdcfffb78a864465d8e9017bfb005ccacc560a8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Module graph analysis for deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"ecosystem_test"
	"fast_check"
	"swc"
	"symbols"
)
