# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="base64"
CRATE_VERSION="0.22.1"
CRATE_CHECKSUM="72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="encodes and decodes base64 as bytes or utf8"
HOMEPAGE="https://github.com/marshallpierce/rust-base64"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
