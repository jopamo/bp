# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fs4"
CRATE_VERSION="0.13.1"
CRATE_CHECKSUM="8640e34b88f7652208ce9e88b1a37a2ae95227d84abec377ccd3c5cfeb141ed4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="No libc, pure Rust cross-platform file locks. Original fs2, now supports async and replace libc by rustix."
HOMEPAGE="https://github.com/al8n/fs4-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-std"
	"default"
	"fs-err2"
	"fs-err2-tokio"
	"fs-err3"
	"fs-err3-tokio"
	"smol"
	"sync"
	"tokio"
)
