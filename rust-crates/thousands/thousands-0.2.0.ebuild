# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="thousands"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="3bf63baf9f5039dadc247375c29eb13706706cfde997d0330d05aa63a77d8820"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Adds digit separators to numbers, configurably."
HOMEPAGE="https://github.com/tov/thousands-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
