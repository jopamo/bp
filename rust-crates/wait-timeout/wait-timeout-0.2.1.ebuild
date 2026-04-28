# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wait-timeout"
CRATE_VERSION="0.2.1"
CRATE_CHECKSUM="09ac3b126d3914f9849036f826e054cbabdc8519970b8998ddaf3b5bd3c65f11"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate to wait on a child process with a timeout specified across Unix and Windows platforms."
HOMEPAGE="https://github.com/alexcrichton/wait-timeout"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
