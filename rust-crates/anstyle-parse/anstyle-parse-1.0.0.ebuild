# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle-parse"
CRATE_VERSION="1.0.0"
CRATE_CHECKSUM="52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse ANSI Style Escapes"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"core"
	"default"
	"utf8"
)
