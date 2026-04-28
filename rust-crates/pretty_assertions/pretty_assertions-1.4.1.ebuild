# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pretty_assertions"
CRATE_VERSION="1.4.1"
CRATE_CHECKSUM="3ae130e2f271fbc2ac3a40fb1d07180839cdbbe443c7a27e1e3c13c5cac0116d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Overwrite `assert_eq!` and `assert_ne!` with drop-in replacements, adding colorful diffs."
HOMEPAGE="https://github.com/rust-pretty-assertions/rust-pretty-assertions"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
	"unstable"
)
