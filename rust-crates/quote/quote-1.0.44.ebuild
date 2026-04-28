# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="quote"
CRATE_VERSION="1.0.44"
CRATE_CHECKSUM="21b2ebcf727b7760c461f091f9f0f539b77b8e87f2fd88131e7f1b433b3cece4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Quasi-quoting macro quote!(...)"
HOMEPAGE="https://github.com/dtolnay/quote"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"proc-macro"
)
