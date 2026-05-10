# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="zbus"
CRATE_VERSION="5.8.0"
CRATE_CHECKSUM="597f45e98bc7e6f0988276012797855613cd8269e23b5be62cc4e5d28b7e515d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="API for D-Bus communication"
HOMEPAGE="https://github.com/dbus2/zbus/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"async-fs"
	"async-io"
	"blocking-api"
	"bus-impl"
	"camino"
	"chrono"
	"default"
	"heapless"
	"option-as-array"
	"p2p"
	"serde_bytes"
	"time"
	"tokio"
	"tokio-vsock"
	"url"
	"uuid"
	"vsock"
)
