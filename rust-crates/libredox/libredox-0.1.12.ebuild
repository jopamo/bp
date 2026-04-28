# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libredox"
CRATE_VERSION="0.1.12"
CRATE_CHECKSUM="3d0b95e02c851351f877147b7deea7b1afb1df71b63aa5f8270716e0c5720616"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Redox stable ABI"
HOMEPAGE="https://gitlab.redox-os.org/redox-os/libredox.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"call"
	"default"
	"mkns"
	"std"
)
