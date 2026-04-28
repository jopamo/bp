# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="block2"
CRATE_VERSION="0.6.2"
CRATE_CHECKSUM="cdeb9d870516001442e364c5220d3574d2da8dc765554b4a617230d33fa58ef5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Apple's C language extension of blocks"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compiler-rt"
	"default"
	"gnustep-1-7"
	"gnustep-1-8"
	"gnustep-1-9"
	"gnustep-2-0"
	"gnustep-2-1"
	"std"
	"unstable-coerce-pointee"
	"unstable-objfw"
	"unstable-private"
	"unstable-winobjc"
)
