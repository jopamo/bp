# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="block2"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="2c132eebf10f5cad5289222520a4a058514204aed6d791f1cf4fe8088b82d15f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Apple's C language extension of blocks"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"apple"
	"compiler-rt"
	"default"
	"gnustep-1-7"
	"gnustep-1-8"
	"gnustep-1-9"
	"gnustep-2-0"
	"gnustep-2-1"
	"std"
	"unstable-objfw"
	"unstable-private"
	"unstable-winobjc"
)
