# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="which"
CRATE_VERSION="6.0.1"
CRATE_CHECKSUM="8211e4f58a2b2805adfbefbc07bab82958fc91e3836339b1ab7ae32465dce0d7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust equivalent of Unix command \"which\". Locate installed executable in cross platforms."
HOMEPAGE="https://github.com/harryfei/which-rs.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
