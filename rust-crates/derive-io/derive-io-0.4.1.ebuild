# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="derive-io"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="58cc7f4740088458993d183a200fe56e62378736f94bf0e2dd45807407e7bb94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="derive macros for \`std::io::{Read,Write}\`, \`tokio::io::{AsyncRead,AsyncWrite}\` and more"
HOMEPAGE="https://github.com/mmastrac/derive-io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
	"tokio"
)
