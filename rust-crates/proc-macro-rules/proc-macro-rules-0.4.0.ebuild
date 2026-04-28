# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro-rules"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="07c277e4e643ef00c1233393c673f655e3672cf7eb3ba08a00bdd0ea59139b5f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Emulate macro-rules pattern matching in procedural macros"
HOMEPAGE="https://github.com/nrc/proc-macro-rules"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
