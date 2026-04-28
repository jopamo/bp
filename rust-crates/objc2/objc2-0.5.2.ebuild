# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="objc2"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="46a785d4eeff09c14c487497c162e92766fbb3e4059a71840cecc03d9a50b804"
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
	"apple"
	"catch-all"
	"default"
	"exception"
	"gnustep-1-7"
	"gnustep-1-8"
	"gnustep-1-9"
	"gnustep-2-0"
	"gnustep-2-1"
	"malloc"
	"relax-sign-encoding"
	"relax-void-encoding"
	"std"
	"unstable-apple-new"
	"unstable-autoreleasesafe"
	"unstable-c-unwind"
	"unstable-compiler-rt"
	"unstable-msg-send-always-comma"
	"unstable-static-class"
	"unstable-static-class-inlined"
	"unstable-static-sel"
	"unstable-static-sel-inlined"
	"verify"
)
