# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="zerofrom-derive"
CRATE_VERSION="0.1.4"
CRATE_CHECKSUM="0ea7b4a3637ea8669cedf0f1fd5c286a17f3de97b8dd5a70a6c167a1730e63a5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Custom derive for the zerofrom crate"
HOMEPAGE="https://github.com/unicode-org/icu4x"
LICENSE="Unicode-3.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"
