# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="generator"
CRATE_VERSION="0.8.4"
CRATE_CHECKSUM="cc6bd114ceda131d3b1d665eba35788690ad37f5916457286b32ab6fd3c438dd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Stackfull Generator Library in Rust"
HOMEPAGE="https://github.com/Xudong-Huang/generator-rs.git"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
