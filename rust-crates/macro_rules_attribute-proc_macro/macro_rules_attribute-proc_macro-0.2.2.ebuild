# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="macro_rules_attribute-proc_macro"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="670fdfda89751bc4a84ac13eaa63e205cf0fd22b4c9a5fbfa085b63c1f1d3a30"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Use declarative macros as proc_macro attributes or derives"
HOMEPAGE="https://github.com/danielhenrymantilla/macro_rules_attribute-rs"
LICENSE="|| ( Apache-2.0 MIT Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"verbose-expansions"
)
