# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="io-extras"
CRATE_VERSION="0.19.0"
CRATE_CHECKSUM="20fd6de4ccfcc187e38bc21cfa543cb5a302cb86a8b114eb7f0bf0dc9f8ac00f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="File/socket handle/descriptor utilities"
HOMEPAGE="https://github.com/sunfishcode/io-extras"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_async_std"
	"use_mio_net"
	"use_mio_os_ext"
	"use_os_pipe"
	"use_socket2"
	"use_tokio"
)
