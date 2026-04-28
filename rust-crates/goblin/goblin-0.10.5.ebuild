# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="goblin"
CRATE_VERSION="0.10.5"
CRATE_CHECKSUM="983a6aafb3b12d4c41ea78d39e189af4298ce747353945ff5105b54a056e5cd9"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An impish, cross-platform, ELF, Mach-o, and PE binary parsing and loading crate"
HOMEPAGE="https://github.com/m4b/goblin"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"archive"
	"default"
	"elf32"
	"elf64"
	"endian_fd"
	"mach32"
	"mach64"
	"pe32"
	"pe64"
	"std"
	"te"
)
