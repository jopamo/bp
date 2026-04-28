# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="scopeguard"
CRATE_VERSION="1.2.0"
CRATE_CHECKSUM="94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A RAII scope guard that will run a given closure when it goes out of scope, even if the code between panics (assuming unwinding panic). Defines the macros `defer!`, `defer_on_unwind!`, `defer_on_success!` as shorthands for guards with one of the implemented strategies."
HOMEPAGE="https://github.com/bluss/scopeguard"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_std"
)
