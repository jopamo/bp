# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="xattr"
CRATE_VERSION="1.3.1"
CRATE_CHECKSUM="8da84f1a25939b27f6820d92aed108f83ff920fdf11a7b19366c27c4cda81d4f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="unix extended filesystem attributes"
HOMEPAGE="https://github.com/Stebalien/xattr"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"unsupported"
)
