# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="deno_ast"
CRATE_VERSION="0.53.3"
CRATE_CHECKSUM="6f7c1384d87fc0a6439a065312fbef8f6ac6128689dbc2831b28b3a1d4f3a4e6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Source text parsing, lexing, and AST related functionality for Deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"bundler"
	"cjs"
	"codegen"
	"compat"
	"concurrent"
	"emit"
	"proposal"
	"react"
	"scopes"
	"sourcemap"
	"transforms"
	"transpiling"
	"type_strip"
	"typescript"
	"utils"
	"view"
	"visit"
)
