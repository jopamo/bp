# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign"
CRATE_VERSION="0.18.1"
CRATE_CHECKSUM="ea386ba750000b6e59f760a08bdcca9461809b95e6f8f209ce5724056802824f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing HTTP requests for AWS, Azure, Google, Huawei, Aliyun, Tencent and Oracle services"
HOMEPAGE="https://github.com/apache/opendal-reqsign"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"aliyun"
	"aws"
	"azure"
	"default"
	"default-context"
	"full"
	"google"
	"huaweicloud"
	"oracle"
	"tencent"
)
