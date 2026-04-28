# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="md-5"
CRATE_VERSION="0.10.6"
CRATE_CHECKSUM="d89e7ee0cfbedfc4da3340218492196241d89eefb6dab27de5df917a6d2e78cf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="MD5 hash function"
HOMEPAGE="https://github.com/RustCrypto/hashes"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"asm"
	"default"
	"force-soft"
	"loongarch64_asm"
	"oid"
	"std"
)
