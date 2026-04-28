# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="group"
CRATE_VERSION="0.13.0"
CRATE_CHECKSUM="f0f9ef7462f7c099f518d754361858f86d8a07af53ba9af0fe635bbccb151a63"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Elliptic curve group traits and utilities"
HOMEPAGE="https://github.com/zkcrypto/group"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"tests"
	"wnaf-memuse"
)
