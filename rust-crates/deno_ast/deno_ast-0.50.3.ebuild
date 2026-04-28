# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_ast"
CRATE_VERSION="0.50.3"
CRATE_CHECKSUM="6c6fca2bd99b9f4ac51e548a34b74f8e397d94694a6ced184315922156f70ed0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Source text parsing, lexing, and AST related functionality for Deno"
HOMEPAGE="https://deno.land/"
LICENSE="MIT"
SLOT="0/${PV}"
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
	"typescript"
	"utils"
	"view"
	"visit"
)
