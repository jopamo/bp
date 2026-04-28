# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dispatch2"
CRATE_VERSION="0.3.0"
CRATE_CHECKSUM="89a09f22a6c6069a18470eb92d2298acf25463f14256d24778e1230d789a2aec"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings and wrappers for Apple's Grand Central Dispatch (GCD)"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block2"
	"default"
	"libc"
	"objc2"
	"std"
)
