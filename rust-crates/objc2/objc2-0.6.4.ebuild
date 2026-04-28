# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2"
CRATE_VERSION="0.6.4"
CRATE_CHECKSUM="3a12a8ed07aefc768292f076dc3ac8c48f3781c8f2d5851dd3d98950e8c5a89f"
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
	"unstable-darwin-objc"
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
