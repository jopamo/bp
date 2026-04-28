# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="macro_rules_attribute"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="65049d7923698040cd0b1ddcced9b0eb14dd22c5f86ae59c3740eab64a676520"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Use declarative macros in attribute or derive position"
HOMEPAGE="https://crates.io/crates/macro_rules_attribute"
LICENSE="|| ( Apache-2.0 MIT Zlib )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"better-docs"
	"default"
	"verbose-expansions"
)
