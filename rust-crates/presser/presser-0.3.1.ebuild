# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="presser"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="e8cf8e6a8aa66ce33f63993ffc4ea4271eb5b0530a9002db8455ea6050c77bfa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate to help you copy things into raw buffers without invoking spooky action at a distance (undefined behavior)."
HOMEPAGE="https://github.com/EmbarkStudios/presser"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
