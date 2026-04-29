# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="protobuf-codegen"
CRATE_VERSION="2.28.0"
CRATE_CHECKSUM="033460afb75cf755fcfc16dfaed20b86468082a2ea24e05ac35ab4a099a017d6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Code generator for rust-protobuf. Includes a library and \`protoc-gen-rust\` binary. See \`protoc-rust\` and \`protobuf-codegen-pure\` crates."
HOMEPAGE="https://github.com/stepancheg/rust-protobuf/"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
