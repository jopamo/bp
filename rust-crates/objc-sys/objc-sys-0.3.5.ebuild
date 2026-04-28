# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc-sys"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="cdb91bdd390c7ce1a8607f35f3ca7151b65afc0ff5ff3b34fa350f7d7c7e4310"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw bindings to the Objective-C runtime and ABI"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"apple"
	"default"
	"gnustep-1-7"
	"gnustep-1-8"
	"gnustep-1-9"
	"gnustep-2-0"
	"gnustep-2-1"
	"std"
	"unstable-c-unwind"
	"unstable-exception"
	"unstable-objfw"
	"unstable-winobjc"
)
