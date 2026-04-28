# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="keyring"
CRATE_VERSION="3.6.3"
CRATE_CHECKSUM="eebcc3aff044e5944a8fbaf69eb277d11986064cba30c468730e8b9909fb551c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform library for managing passwords/credentials"
HOMEPAGE="https://github.com/hwchen/keyring-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"apple-native"
	"async-io"
	"async-secret-service"
	"crypto-openssl"
	"crypto-rust"
	"linux-native"
	"linux-native-async-persistent"
	"linux-native-sync-persistent"
	"sync-secret-service"
	"tokio"
	"vendored"
	"windows-native"
)
