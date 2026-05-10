# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="goblin"
CRATE_VERSION="0.10.1"
CRATE_CHECKSUM="d6a80adfd63bd7ffd94fefc3d22167880c440a724303080e5aa686fa36abaa96"
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
