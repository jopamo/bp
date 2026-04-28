# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2"
CRATE_VERSION="0.6.3"
CRATE_CHECKSUM="b7c2599ce0ec54857b29ce62166b0ed9b4f6f1a70ccc9a71165b6154caca8c05"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Objective-C interface and runtime bindings"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"catch-all"
	"default"
	"disable-encoding-assertions"
	"exception"
	"gnustep-1-7"
	"gnustep-1-8"
	"gnustep-1-9"
	"gnustep-2-0"
	"gnustep-2-1"
	"objc2-proc-macros"
	"relax-sign-encoding"
	"relax-void-encoding"
	"std"
	"unstable-apple-new"
	"unstable-arbitrary-self-types"
	"unstable-autoreleasesafe"
	"unstable-coerce-pointee"
	"unstable-compiler-rt"
	"unstable-gnustep-strict-apple-compat"
	"unstable-objfw"
	"unstable-requires-macos"
	"unstable-static-class"
	"unstable-static-class-inlined"
	"unstable-static-sel"
	"unstable-static-sel-inlined"
	"unstable-winobjc"
	"verify"
)
