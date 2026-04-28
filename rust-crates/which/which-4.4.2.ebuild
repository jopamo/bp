# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="which"
CRATE_VERSION="4.4.2"
CRATE_CHECKSUM="87ba24419a2078cd2b0f2ede2691b6c66d8e47836da3b6db8265ebad47afbfc7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust equivalent of Unix command \"which\". Locate installed executable in cross platforms."
HOMEPAGE="https://github.com/harryfei/which-rs.git"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
