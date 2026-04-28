# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="mime_guess"
CRATE_VERSION="2.0.5"
CRATE_CHECKSUM="f7c44f8e672c00fe5308fa235f821cb4198414e1c77935c1ab6948d3fd78550e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple crate for detection of a file's MIME type by its extension."
HOMEPAGE="https://github.com/abonander/mime_guess"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rev-mappings"
)
