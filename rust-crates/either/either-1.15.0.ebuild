# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="either"
CRATE_VERSION="1.15.0"
CRATE_CHECKSUM="48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The enum \`Either\` with variants \`Left\` and \`Right\` is a general purpose sum type with two cases."
HOMEPAGE="https://github.com/rayon-rs/either"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"use_std"
)
