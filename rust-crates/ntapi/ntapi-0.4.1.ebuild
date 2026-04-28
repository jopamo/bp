# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ntapi"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="e8a3895c6391c39d7fe7ebc444a87eb2991b2a0bc718fdabd071eec617fc68e4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings for Native API"
HOMEPAGE="https://github.com/MSxDOS/ntapi"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"func-types"
	"impl-default"
	"kernel"
	"user"
)
