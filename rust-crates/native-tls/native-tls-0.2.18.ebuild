# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="native-tls"
CRATE_VERSION="0.2.18"
CRATE_CHECKSUM="465500e14ea162429d264d44189adc38b199b62b1c21eea9f69e4b73cb03bbf2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A wrapper over a platform's native TLS implementation"
HOMEPAGE="https://lib.rs/crates/native-tls"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alpn"
	"alpn-accept"
	"default"
	"vendored"
)
