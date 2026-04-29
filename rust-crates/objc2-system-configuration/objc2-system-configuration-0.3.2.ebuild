# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="objc2-system-configuration"
CRATE_VERSION="0.3.2"
CRATE_CHECKSUM="7216bd11cbda54ccabcab84d523dc93b858ec75ecfb3a7d89513fa22464da396"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to the SystemConfiguration framework"
HOMEPAGE="https://github.com/madsmtm/objc2"
LICENSE="|| ( Zlib Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"CaptiveNetwork"
	"DHCPClientPreferences"
	"SCDynamicStore"
	"SCDynamicStoreCopyDHCPInfo"
	"SCDynamicStoreCopySpecific"
	"SCDynamicStoreKey"
	"SCNetwork"
	"SCNetworkConfiguration"
	"SCNetworkConnection"
	"SCNetworkReachability"
	"SCPreferences"
	"SCPreferencesPath"
	"SCPreferencesSetSpecific"
	"SCSchemaDefinitions"
	"alloc"
	"bitflags"
	"default"
	"dispatch2"
	"libc"
	"objc2"
	"objc2-security"
	"std"
	"unstable-darwin-objc"
)
