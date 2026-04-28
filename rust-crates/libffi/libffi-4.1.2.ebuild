# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libffi"
CRATE_VERSION="4.1.2"
CRATE_CHECKSUM="b0feebbe0ccd382a2790f78d380540500d7b78ed7a3498b68fcfbc1593749a94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust bindings for libffi"
HOMEPAGE="https://github.com/tov/libffi-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"check_only"
	"complex"
	"system"
)
