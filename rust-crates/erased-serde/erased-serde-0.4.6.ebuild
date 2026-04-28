# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="erased-serde"
CRATE_VERSION="0.4.6"
CRATE_CHECKSUM="e004d887f51fcb9fef17317a2f3525c887d8aa3f4f50fed920816a688284a5b7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Type-erased Serialize and Serializer traits"
HOMEPAGE="https://github.com/dtolnay/erased-serde"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
	"unstable-debug"
)
