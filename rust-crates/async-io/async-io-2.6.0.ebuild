# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="async-io"
CRATE_VERSION="2.6.0"
CRATE_CHECKSUM="456b8a8feb6f42d237746d4b3e9a178494627745c3c56c6ea55d92ba50d026fc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Async I/O and timers"
HOMEPAGE="https://github.com/smol-rs/async-io"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
