# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="relative-path"
CRATE_VERSION="1.9.3"
CRATE_CHECKSUM="ba39f3699c378cd8970968dcbff9c43159ea4cfbd88d43c00b22f2ef10a435d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Portable, relative paths for Rust."
HOMEPAGE="https://github.com/udoprog/relative-path"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
