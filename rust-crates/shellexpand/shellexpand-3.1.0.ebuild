# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="shellexpand"
CRATE_VERSION="3.1.0"
CRATE_CHECKSUM="da03fa3b94cc19e3ebfc88c4229c49d8f08cdbd1228870a45f0ffdf84988e14b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Shell-like expansions in strings"
HOMEPAGE="https://gitlab.com/ijackson/rust-shellexpand"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"base-0"
	"default"
	"full"
	"full-msrv-1-31"
	"full-msrv-1-51"
	"path"
	"tilde"
)
