# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="idna"
CRATE_VERSION="1.1.0"
CRATE_CHECKSUM="3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="IDNA (Internationalizing Domain Names in Applications) and Punycode."
HOMEPAGE="https://github.com/servo/rust-url/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"compiled_data"
	"default"
	"std"
)
