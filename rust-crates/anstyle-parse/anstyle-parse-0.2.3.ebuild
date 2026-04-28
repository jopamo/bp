# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-parse"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="c75ac65da39e5fe5ab759307499ddad880d724eed2f6ce5b5e8a26f4f387928c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse ANSI Style Escapes"
HOMEPAGE="https://github.com/rust-cli/anstyle"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"utf8"
)
