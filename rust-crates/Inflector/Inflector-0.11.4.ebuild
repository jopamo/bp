# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="Inflector"
CRATE_VERSION="0.11.4"
CRATE_CHECKSUM="fe438c63458706e03479442743baae6c88256498e6431708f6dfc520a26515d3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adds String based inflections for Rust. Snake, kebab, camel, sentence, class, title and table cases as well as ordinalize, deordinalize, demodulize, foreign key, and pluralize/singularize are supported as both traits and pure functions acting on String types."
HOMEPAGE="https://github.com/whatisinternet/inflector"
LICENSE="BSD-2-Clause"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"heavyweight"
	"unstable"
)
