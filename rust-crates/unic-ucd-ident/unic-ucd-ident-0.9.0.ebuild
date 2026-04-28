# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="unic-ucd-ident"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="e230a37c0381caa9219d67cf063aa3a375ffed5bf541a452db16e744bdab6987"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UNIC — Unicode Character Database — Identifier Properties"
HOMEPAGE="https://github.com/open-i18n/rust-unic/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"id"
	"pattern"
	"xid"
)
