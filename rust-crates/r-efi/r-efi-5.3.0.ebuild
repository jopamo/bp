# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="r-efi"
CRATE_VERSION="5.3.0"
CRATE_CHECKSUM="69cdb34c158ceb288df11e18b4bd39de994f6657d83847bdffdbd7f346754b0f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UEFI Reference Specification Protocol Constants and Definitions"
HOMEPAGE="https://github.com/r-efi/r-efi/wiki"
LICENSE="|| ( MIT Apache-2.0 LGPL-2.1-or-later )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"efiapi"
	"examples"
	"native"
	"rustc-dep-of-std"
)
