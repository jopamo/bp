# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="windows-targets"
CRATE_VERSION="0.48.5"
CRATE_CHECKSUM="9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Import libs for Windows"
HOMEPAGE="https://github.com/microsoft/windows-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
