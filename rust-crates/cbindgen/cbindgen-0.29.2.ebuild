# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cbindgen"
CRATE_VERSION="0.29.2"
CRATE_CHECKSUM="befbfd072a8e81c02f8c507aefce431fe5e7d051f83d48a23ffc9b9fe5a11799"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tool for generating C bindings to Rust code."
HOMEPAGE="https://github.com/mozilla/cbindgen"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"unstable_ir"
)
