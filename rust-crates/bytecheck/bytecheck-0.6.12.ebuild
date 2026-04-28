# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytecheck"
CRATE_VERSION="0.6.12"
CRATE_CHECKSUM="23cdc57ce23ac53c931e88a43d06d070a6fd142f2617be5855eb75efc9beb1c2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Derive macro for bytecheck"
HOMEPAGE="https://github.com/djkoloski/bytecheck"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"verbose"
)
