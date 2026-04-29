# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="ipnet"
CRATE_VERSION="2.12.0"
CRATE_CHECKSUM="d98f6fed1fde3f8c21bc40a1abb88dd75e67924f9cffc3ef95607bad8017f8e2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides types and useful methods for working with IPv4 and IPv6 network addresses, commonly called IP prefixes. The new \`IpNet\`, \`Ipv4Net\`, and \`Ipv6Net\` types build on the existing \`IpAddr\`, \`Ipv4Addr\`, and \`Ipv6Addr\` types already provided in Rust's standard library and align to their design to stay consistent. The module also provides useful traits that extend \`Ipv4Addr\` and \`Ipv6Addr\` with methods for \`Add\`, \`Sub\`, \`BitAnd\`, and \`BitOr\` operations. The module only uses stable feature so it is guaranteed to compile using the stable toolchain."
HOMEPAGE="https://github.com/krisprice/ipnet"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"heapless"
	"json"
	"schemars"
	"schemars08"
	"schemars1"
	"ser_as_str"
	"serde"
	"std"
)
