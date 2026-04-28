# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="color-print-proc-macro"
CRATE_VERSION="0.3.5"
CRATE_CHECKSUM="57e37866456a721d0a404439a1adae37a31be4e0055590d053dfe6981e05003f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation for the package color-print"
HOMEPAGE="https://gitlab.com/dajoha/color-print"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"terminfo"
)
