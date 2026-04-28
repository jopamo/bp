# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="minimal-lexical"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast float parsing conversion routines."
HOMEPAGE="https://github.com/Alexhuszagh/minimal-lexical"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compact"
	"default"
	"lint"
	"nightly"
	"std"
)
