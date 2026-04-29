# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="openssl-probe"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="7c87def4c32ab89d880effc9e097653c8da5d6ef28e6b539d313baaacfbafcbe"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library for helping to find system-wide trust anchor (\"root\") certificate locations based on paths typically used by \`openssl\`."
HOMEPAGE="https://github.com/rustls/openssl-probe"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
