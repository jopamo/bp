# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="time-core"
CRATE_VERSION="0.1.2"
CRATE_CHECKSUM="ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate is an implementation detail and should not be relied upon directly."
HOMEPAGE="https://github.com/time-rs/time"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
