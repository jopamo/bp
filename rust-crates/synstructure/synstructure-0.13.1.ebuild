# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="synstructure"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="c8af7666ab7b6390ab78131fb5b0fce11d6b7a6951602017c35fa82800708971"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Helper methods and macros for custom derives"
HOMEPAGE="https://github.com/mystor/synstructure"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
