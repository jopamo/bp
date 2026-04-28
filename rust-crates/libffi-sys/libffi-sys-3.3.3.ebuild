# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libffi-sys"
CRATE_VERSION="3.3.3"
CRATE_CHECKSUM="90c6c6e17136d4bc439d43a2f3c6ccf0731cccc016d897473a29791d3c2160c3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw Rust bindings for libffi"
HOMEPAGE="https://github.com/tov/libffi-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"check_only"
	"complex"
	"system"
)
