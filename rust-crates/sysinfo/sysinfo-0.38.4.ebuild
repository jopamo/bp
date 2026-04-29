# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="sysinfo"
CRATE_VERSION="0.38.4"
CRATE_CHECKSUM="92ab6a2f8bfe508deb3c6406578252e491d299cbbf3bc0529ecc3313aee4a52f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Library to get system information such as processes, CPUs, disks, components and networks"
HOMEPAGE="https://github.com/GuillaumeGomez/sysinfo"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"apple-app-store"
	"apple-sandbox"
	"c-interface"
	"component"
	"debug"
	"default"
	"disk"
	"linux-netdevs"
	"linux-tmpfs"
	"multithread"
	"network"
	"system"
	"unknown-ci"
	"user"
)
