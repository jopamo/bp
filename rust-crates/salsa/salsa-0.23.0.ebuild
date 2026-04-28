# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="salsa"
CRATE_VERSION="0.23.0"
CRATE_CHECKSUM="2e235afdb8e510f38a07138fbe5a0b64691894358a9c0cbd813b1aade110efc9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic framework for on-demand, incrementalized computation (experimental)"
HOMEPAGE="https://github.com/salsa-rs/salsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"macros"
	"salsa_unstable"
	"shuttle"
)
