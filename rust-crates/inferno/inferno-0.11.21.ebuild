# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="inferno"
CRATE_VERSION="0.11.21"
CRATE_CHECKSUM="232929e1d75fe899576a3d5c7416ad0d88dbfbb3c3d6aa00873a7408a50ddb88"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Rust port of the FlameGraph performance profiling tool suite"
HOMEPAGE="https://github.com/jonhoo/inferno.git"
LICENSE="CDDL-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cli"
	"default"
	"multithreaded"
	"nameattr"
)
