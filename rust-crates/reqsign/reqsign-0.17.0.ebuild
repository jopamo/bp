# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="reqsign"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="be18806fe2251c9924d875549573c9bf0e43b51d7efcf32a19ec31bb32196987"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Signing HTTP requests for AWS, Azure, Google, Huawei, Aliyun, Tencent and Oracle services"
HOMEPAGE="https://github.com/Xuanwo/reqsign"
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
