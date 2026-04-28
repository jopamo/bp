# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ascii"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="d92bec98840b8f03a5ff5413de5293bfcd8bf96467cf5452609f939ec6f5de16"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ASCII-only equivalents to \`char\`, \`str\` and \`String\`."
HOMEPAGE="https://github.com/tomprogrammer/rust-ascii"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"std"
)
