# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hermit-abi"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="fc0fef456e4baa96da950455cd02c081ca953b141298e41db3fc7e36b1da849c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hermit system calls definitions."
HOMEPAGE="https://github.com/hermit-os/hermit-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"rustc-dep-of-std"
)
