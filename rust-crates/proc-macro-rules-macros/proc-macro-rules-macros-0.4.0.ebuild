# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="proc-macro-rules-macros"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="207fffb0fe655d1d47f6af98cc2793405e85929bdbc420d685554ff07be27ac7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Emulate macro-rules pattern matching in procedural macros"
HOMEPAGE="https://github.com/nrc/proc-macro-rules"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
