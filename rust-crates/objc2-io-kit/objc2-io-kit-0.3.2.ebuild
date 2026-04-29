# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="objc2-io-kit"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="33fafba39597d6dc1fb709123dfa8289d39406734be322956a69f0931c73bb15"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the IOKit framework"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"AppleUSBDefinitions"
	"IOUSBHostFamilyDefinitions"
	"IOUSBLib"
	"USB"
	"USBSpec"
	"alloc"
	"bitflags"
	"block2"
	"default"
	"dispatch2"
	"graphics"
	"hid"
	"hidsystem"
	"libc"
	"network"
	"objc2"
	"ps"
	"pwr_mgt"
	"serial"
	"std"
	"unstable-darwin-objc"
	"usb"
)
