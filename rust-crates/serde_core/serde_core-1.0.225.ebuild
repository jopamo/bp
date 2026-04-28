# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_core"
CRATE_VERSION="1.0.225"
CRATE_CHECKSUM="659356f9a0cb1e529b24c01e43ad2bdf520ec4ceaf83047b83ddcc2251f96383"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Serde traits only, with no support for derive -- use the \`serde\` crate instead"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"rc"
	"result"
	"std"
	"unstable"
)
