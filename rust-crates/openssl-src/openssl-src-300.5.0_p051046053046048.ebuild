# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="openssl-src"
CRATE_VERSION="300.5.0+3.5.0"
CRATE_CHECKSUM="e8ce546f549326b0e6052b649198487d91320875da901e7bd11a06d1ee3f9c2f"
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
	"weak-crypto"
)
