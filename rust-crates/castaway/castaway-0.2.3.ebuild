# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="castaway"
CRATE_VERSION="0.2.3"
CRATE_CHECKSUM="0abae9be0aaf9ea96a3b1b8b1b55c602ca751eba1b1500220cea4ecbafe7c0d5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe, zero-cost downcasting for limited compile-time specialization."
HOMEPAGE="https://github.com/sagebind/castaway"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
