# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2-uniform-type-identifiers"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="44fa5f9748dbfe1ca6c0b79ad20725a11eca7c2218bceb4b005cb1be26273bfe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the UniformTypeIdentifiers framework"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"NSItemProvider_UTType"
	"UTAdditions"
	"UTCoreTypes"
	"UTDefines"
	"UTTagClass"
	"UTType"
	"all"
	"alloc"
	"block2"
	"default"
	"std"
)
