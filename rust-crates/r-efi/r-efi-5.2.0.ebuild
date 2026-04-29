# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="r-efi"
CRATE_VERSION="5.2.0"
CRATE_CHECKSUM="74765f6d916ee2faa39bc8e68e4f3ed8949b48cccdac59983d287a7cb71ce9c5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UEFI Reference Specification Protocol Constants and Definitions"
HOMEPAGE="https://github.com/r-efi/r-efi/wiki"
LICENSE="|| ( MIT Apache-2.0 LGPL-2.1-or-later )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"efiapi"
	"examples"
	"native"
	"rustc-dep-of-std"
)
