# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dirs"
CRATE_VERSION="5.0.1"
CRATE_CHECKSUM="44c45a9d03d6676652bcb5e724c7e988de1acad23a711b5217ab9cbecbec2225"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tiny low-level library that provides platform-specific standard locations of directories for config, cache and other data on Linux, Windows, macOS and Redox by leveraging the mechanisms defined by the XDG base/user directory specifications on Linux, the Known Folder API on Windows, and the Standard Directory guidelines on macOS."
HOMEPAGE="https://github.com/soc/dirs-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"
