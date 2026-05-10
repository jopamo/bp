# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="enumflags2_derive"
CRATE_VERSION="0.7.12"
CRATE_CHECKSUM="67c78a4d8fdf9953a5c9d458f9efe940fd97a0cab0941c075a813ac594733827"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Do not use directly, use the reexport in the \`enumflags2\` crate. This allows for better compatibility across versions."
HOMEPAGE="https://github.com/meithecatte/enumflags2"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
