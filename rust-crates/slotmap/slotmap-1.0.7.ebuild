# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="slotmap"
CRATE_VERSION="1.0.7"
CRATE_CHECKSUM="dbff4acf519f630b3a3ddcfaea6c06b42174d9a44bc70c620e9ed1649d58b82a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Slotmap data structure"
HOMEPAGE="https://github.com/orlp/slotmap"
LICENSE="Zlib"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"unstable"
)
