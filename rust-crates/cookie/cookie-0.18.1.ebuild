# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cookie"
CRATE_VERSION="0.18.1"
CRATE_CHECKSUM="4ddef33a339a91ea89fb53151bd0a4689cfce27055c291dfa69945475d22c747"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="HTTP cookie parsing and cookie jar management. Supports signed and private (encrypted, authenticated) jars."
HOMEPAGE="https://github.com/SergioBenitez/cookie-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"key-expansion"
	"percent-encode"
	"private"
	"secure"
	"signed"
)
