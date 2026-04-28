# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="keyring"
CRATE_VERSION="2.3.3"
CRATE_CHECKSUM="363387f0019d714aa60cc30ab4fe501a747f4c08fc58f069dd14be971bd495a0"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform library for managing passwords/credentials"
HOMEPAGE="https://github.com/hwchen/keyring-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"linux-default-keyutils"
	"linux-no-secret-service"
	"linux-secret-service"
	"linux-secret-service-rt-async-io-crypto-openssl"
	"linux-secret-service-rt-async-io-crypto-rust"
	"linux-secret-service-rt-tokio-crypto-openssl"
	"linux-secret-service-rt-tokio-crypto-rust"
	"platform-all"
	"platform-freebsd"
	"platform-ios"
	"platform-linux"
	"platform-macos"
	"platform-openbsd"
	"platform-windows"
	"windows-test-threading"
)
