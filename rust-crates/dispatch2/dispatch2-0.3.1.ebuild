# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dispatch2"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="1e0e367e4e7da84520dedcac1901e4da967309406d1e51017ae1abfb97adbd38"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings and wrappers for Apple's Grand Central Dispatch (GCD)"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"block2"
	"default"
	"libc"
	"objc2"
	"std"
)
