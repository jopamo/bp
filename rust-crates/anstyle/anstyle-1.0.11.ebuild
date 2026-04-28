# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anstyle"
CRATE_VERSION="1.0.11"
CRATE_CHECKSUM="862ed96ca487e809f1c8e5a8447f6ee2cf102f846893800b20cebdf541fc6bbd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ANSI text styling"
HOMEPAGE="https://github.com/rust-cli/anstyle.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
