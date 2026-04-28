# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="libm"
CRATE_VERSION="0.2.8"
CRATE_CHECKSUM="4ec2a862134d2a7d32d7983ddcdd1c4923530833c9f2ea1a44fc5fa473989058"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="libm in pure Rust"
HOMEPAGE="https://github.com/rust-lang/libm"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"musl-reference-tests"
	"unstable"
)
