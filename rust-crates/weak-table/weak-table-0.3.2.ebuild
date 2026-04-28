# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="weak-table"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="323f4da9523e9a669e1eaf9c6e763892769b1d38c623913647bfdc1532fe4549"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Weak hash maps and sets"
HOMEPAGE="https://github.com/tov/weak-table-rs"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
