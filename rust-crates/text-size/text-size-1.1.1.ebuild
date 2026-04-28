# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="text-size"
CRATE_VERSION="1.1.1"
CRATE_CHECKSUM="f18aa187839b2bdb1ad2fa35ead8c4c2976b64e4363c386d45ac0f7ee85c9233"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Newtypes for text offsets"
HOMEPAGE="https://github.com/rust-analyzer/text-size"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
