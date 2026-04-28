# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="predicates"
CRATE_VERSION="3.1.3"
CRATE_CHECKSUM="a5d19ee57562043d37e82899fade9a22ebab7be9cef5026b07fda9cdd4293573"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of boolean-valued predicate functions."
HOMEPAGE="https://github.com/assert-rs/predicates-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"color"
	"default"
	"diff"
	"unstable"
)
