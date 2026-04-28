# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dlopen2"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="6bc2c7ed06fd72a8513ded8d0d2f6fd2655a85d6885c48cae8625d80faf28c03"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library for opening and operating on dynamic link libraries (also known as shared objects or shared libraries)."
HOMEPAGE="https://github.com/OpenByteDev/dlopen2"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"derive"
	"doc_cfg"
	"symbor"
	"wrapper"
)
