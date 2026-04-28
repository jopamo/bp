# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ar_archive_writer"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="7eb93bbb63b9c227414f6eb3a0adfddca591a8ce1e9b60661bb08969b87e340b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A writer for object file ar archives"
HOMEPAGE="https://github.com/rust-lang/ar_archive_writer"
LICENSE="Apache-2.0-with-LLVM-exception"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
