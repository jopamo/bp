# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="errno"
CRATE_VERSION="0.3.14"
CRATE_CHECKSUM="39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform interface to the `errno` variable."
HOMEPAGE="https://github.com/lambda-fairy/rust-errno"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
