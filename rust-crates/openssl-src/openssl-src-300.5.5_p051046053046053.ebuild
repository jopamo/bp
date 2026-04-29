# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="openssl-src"
CRATE_VERSION="300.5.5+3.5.5"
CRATE_CHECKSUM="3f1787d533e03597a7934fd0a765f0d28e94ecc5fb7789f8053b1e699a56f709"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Source of OpenSSL and logic to build it."
HOMEPAGE="https://github.com/alexcrichton/openssl-src-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"camellia"
	"default"
	"force-engine"
	"idea"
	"ktls"
	"legacy"
	"no-dso"
	"seed"
	"ssl3"
	"weak-crypto"
)
