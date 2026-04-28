# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2-link-presentation"
CRATE_VERSION="0.2.2"
CRATE_CHECKSUM="a1a1ae721c5e35be65f01a03b6d2ac13a54cb4fa70d8a5da293d7b0020261398"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the LinkPresentation framework"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"LPError"
	"LPFoundation"
	"LPLinkMetadata"
	"LPLinkView"
	"LPMetadataProvider"
	"all"
	"alloc"
	"block2"
	"default"
	"objc2-app-kit"
	"std"
)
