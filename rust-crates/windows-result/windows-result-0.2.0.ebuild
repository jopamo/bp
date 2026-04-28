# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-result"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="1d1043d8214f791817bab27572aaa8af63732e11bf84aa21a45a78d6c317ae0e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Windows error handling"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
