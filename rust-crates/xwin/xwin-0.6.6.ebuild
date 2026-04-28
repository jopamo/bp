# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xwin"
CRATE_VERSION="0.6.6"
CRATE_CHECKSUM="524ca49a2ace663f105ea14006a1ead16f5ba53c2159a6959f562d5f746e8b06"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Allows downloading and repacking the MSVC CRT and Windows SDK for cross compilation"
HOMEPAGE="https://github.com/Jake-Shadle/xwin"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"native-tls"
	"rustls-tls"
)
