# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="open"
CRATE_VERSION="5.1.2"
CRATE_CHECKSUM="449f0ff855d85ddbf1edd5b646d65249ead3f5e422aaa86b7d2d0b049b103e32"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Open a path or URL using the program configured on the system"
HOMEPAGE="https://github.com/Byron/open-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"shellexecute-on-windows"
)
