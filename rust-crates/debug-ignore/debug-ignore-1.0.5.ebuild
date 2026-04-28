# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="debug-ignore"
CRATE_VERSION="1.0.5"
CRATE_CHECKSUM="ffe7ed1d93f4553003e20b629abe9085e1e81b1429520f897f8f8860bc6dfc21"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A newtype wrapper that causes a field to be skipped while printing out Debug output."
HOMEPAGE="https://github.com/sunshowers-code/debug-ignore"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
