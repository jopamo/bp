# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="rustls-platform-verifier"
CRATE_VERSION="0.6.2"
CRATE_CHECKSUM="1d99feebc72bae7ab76ba994bb5e121b8d83d910ca40b36e0921f53becc41784"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="rustls-platform-verifier supports verifying TLS certificates in rustls with the operating system verifier"
HOMEPAGE="https://github.com/rustls/rustls-platform-verifier"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cert-logging"
	"dbg"
	"docsrs"
	"ffi-testing"
)
