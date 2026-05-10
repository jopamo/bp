# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="sys-info"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="0b3a0d0aba8bf96a0e1ddfdc352fc53b3df7f39318c71854910c3c4b024ae52c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Get system information in Rust. For now it supports Linux, Mac OS X, illumos, Solaris, FreeBSD, OpenBSD, and Windows."
HOMEPAGE="https://github.com/FillZpp/sys-info-rs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
