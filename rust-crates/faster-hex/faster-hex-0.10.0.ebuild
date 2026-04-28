# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="faster-hex"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="7223ae2d2f179b803433d9c830478527e92b8117eab39460edae7f1614d9fb73"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fast hex encoding."
HOMEPAGE="https://github.com/NervosFoundation/faster-hex"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"serde"
	"std"
)
