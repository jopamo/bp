# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="form_urlencoded"
CRATE_VERSION="1.2.3"
CRATE_CHECKSUM="afa489199eaffb1211795df1c6236ce1ad0d41a6fa45250add73e3b02420f06e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parser and serializer for the application/x-www-form-urlencoded syntax, as used by HTML forms."
HOMEPAGE="https://github.com/servo/rust-url"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
