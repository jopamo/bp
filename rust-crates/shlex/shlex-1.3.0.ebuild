# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="shlex"
CRATE_VERSION="1.3.0"
CRATE_CHECKSUM="0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Split a string into shell words, like Python's shlex."
HOMEPAGE="https://github.com/comex/rust-shlex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
