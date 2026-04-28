# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fallible-iterator"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Fallible iterator traits"
HOMEPAGE="https://github.com/sfackler/rust-fallible-iterator"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
