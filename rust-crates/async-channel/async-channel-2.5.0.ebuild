# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-channel"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="924ed96dd52d1b75e9c1a3e6275715fd320f5f9439fb5a4a11fa51f4221158d2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Async multi-producer multi-consumer channel"
HOMEPAGE="https://github.com/smol-rs/async-channel"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"portable-atomic"
	"std"
)
