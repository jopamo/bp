# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="html-escape"
CRATE_VERSION="0.2.13"
CRATE_CHECKSUM="6d1ad449764d627e22bfd7cd5e8868264fc9236e07c752972b4080cd351cb476"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This library is for encoding/escaping special characters in HTML and decoding/unescaping HTML entities as well."
HOMEPAGE="https://magiclen.org/html-escape"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
