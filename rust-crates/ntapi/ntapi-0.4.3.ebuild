# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="ntapi"
CRATE_VERSION="0.4.3"
CRATE_CHECKSUM="c3b335231dfd352ffb0f8017f3b6027a4917f7df785ea2143d8af2adc66980ae"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="FFI bindings for Native API"
HOMEPAGE="https://github.com/MSxDOS/ntapi"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"func-types"
	"impl-default"
	"kernel"
	"user"
)
